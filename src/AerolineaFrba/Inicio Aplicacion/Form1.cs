﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AerolineaFrba.Inicio_Aplicacion;


namespace AerolineaFrba
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {   
            //ESTO DEBERIA DE MANDARTE AL LOGIN!!!!!!!!!!!
 
            this.Visible = false;
            Form frm = new FormInicioFuncionalidades();
            frm.ShowDialog();
            frm = (FormInicioFuncionalidades)this.ActiveMdiChild;
        }
    }
}