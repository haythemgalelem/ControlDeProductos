﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ControlProductos
{
    public partial class AdministrarProducto : Form
    {
        public AdministrarProducto()
        {
            InitializeComponent();
        }

        //private void cmbfamilia_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //    cmbrubros.DataSource = null;
        //    cmbrubros.Items.Clear();
        //    RubroDao oRubro = new RubroDao();
        //    cmbrubros.DataSource = oRubro.obtenerRubro(((Familia)cmbfamilias.SelectedItem).Id);
        //    cmbrubros.DisplayMember = "Nombre";
        //    cmbrubros.ValueMember = "Id";
        //    cmbrubros.SelectedIndex = -1;
        //}

        private void AdministrarProducto_Load(object sender, EventArgs e)
        {
            btneditar.Visible = false;
            bnteliminar.Visible = false;            
            CargarCombos();
        }

        private void CargarCombos()
        {
            ProveedorDao oProveedor = new ProveedorDao();
            cmbproveedores.DataSource = oProveedor.obtenerProveedores();
            cmbproveedores.DisplayMember = "Nombre";
            cmbproveedores.ValueMember = "Id";

            FamiliaDao oFamilia = new FamiliaDao();
            cmbfamilias.DataSource = oFamilia.obtenerFamilia();
            cmbfamilias.DisplayMember = "Nombre";
            cmbfamilias.ValueMember = "Id";

            //cmbrubros.DataSource = null;
            //cmbrubros.Items.Clear();
            RubroDao oRubro = new RubroDao();
            cmbrubros.DataSource = oRubro.obtenerRubro();
            cmbrubros.DisplayMember = "Nombre";
            cmbrubros.ValueMember = "Id";
        }

        private void btnnuevo_Click(object sender, EventArgs e)
        {
            ProductoABM oProducto = new ProductoABM();
            oProducto.ShowDialog();
            this.Hide();
        }

        private void btnvolver_Click(object sender, EventArgs e)
        {
            MenuPrincipal MenuPrin = new MenuPrincipal();
            MenuPrin.Show();
            this.Close();
        }

        private void btnbuscar_Click(object sender, EventArgs e)
        {
            ProductoDao oProductos = new ProductoDao();
            dgvproveedores.DataSource = oProductos.buscarProducto(cmbfamilias.SelectedValue.ToString(), cmbrubros.SelectedValue.ToString(), cmbproveedores.SelectedValue.ToString(), txbbuscar.Text);
            dgvproveedores.Columns["IdProveedor"].Visible = false;
            dgvproveedores.Columns["IdRubro"].Visible = false;
            dgvproveedores.Columns["IdFamilia"].Visible = false;        
        }
        
        private void btneditar_Click(object sender, EventArgs e)
        {
            Producto oProducto = enviarProdEditar(); 
            ProductoABM EditarProducto = new ProductoABM();
            EditarProducto.objProductoParaEditar = oProducto;
            EditarProducto.ShowDialog();         
            
        }

        private Producto enviarProdEditar()
        {
            Producto oProducto = new Producto();
            oProducto.Codigo = Convert.ToInt32(this.dgvproveedores.CurrentRow.Cells["Codigo"].Value.ToString());
            oProducto.Nombre = this.dgvproveedores.CurrentRow.Cells["Nombre"].Value.ToString();
            oProducto.Descripcion = this.dgvproveedores.CurrentRow.Cells["Descripcion"].Value.ToString();
            oProducto.Proveedor.Id = Convert.ToInt32(this.dgvproveedores.CurrentRow.Cells["IdProveedor"].Value.ToString());
            oProducto.Rubro.Familia.Id = Convert.ToInt32(this.dgvproveedores.CurrentRow.Cells["IdFamilia"].Value.ToString());
            oProducto.Rubro.Id = Convert.ToInt32(this.dgvproveedores.CurrentRow.Cells["IdRubro"].Value.ToString());
            oProducto.Marca = this.dgvproveedores.CurrentRow.Cells["Marca"].Value.ToString();
            oProducto.Precio = Convert.ToDecimal(this.dgvproveedores.CurrentRow.Cells["Precio"].Value.ToString());

            return oProducto;
        }

        private void bnteliminar_Click(object sender, EventArgs e)
        {
            Producto oProducto = new Producto();
            oProducto.Codigo = Convert.ToInt32(this.dgvproveedores.CurrentRow.Cells["Codigo"].Value.ToString());
            ProductoDao oProductoDAO = new ProductoDao();
            if (oProductoDAO.bajaProducto(oProducto))
            {
                MessageBox.Show("PRODUCTO DADO DE BAJA", "CORRECTO");

            }
            else
            {
                MessageBox.Show("ERROR AL DAR LA BAJA", "CORRECTO");
            }


        }
    }
}