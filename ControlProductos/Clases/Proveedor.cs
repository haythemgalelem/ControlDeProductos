﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ControlProductos
{
<<<<<<< HEAD
    public class Proveedor
=======
<<<<<<< HEAD
    public class Proveedor
=======
    class Proveedor
>>>>>>> origin/master
>>>>>>> origin/master
    {
        public int Id { get; set; }
        public String Nombre{ get; set; }
        public String Direccion{ get; set; }

        
        public Proveedor() { }


        public Proveedor(int pId, string pNombre, string pDireccion)
        {
            this.Id = pId;
            this.Nombre = pNombre;
            this.Direccion = pDireccion;

        }

    }

}
