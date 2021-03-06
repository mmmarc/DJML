﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using AerolineaFrba.Properties;

namespace AerolineaFrba.Abm_Ruta
{
    public partial class FormRutaAlta : Form
    {
        public FormRutaAlta()
        {
            InitializeComponent();
        }

        private void FormRutaAlta_Load(object sender, EventArgs e)
        {
            llenar_combo_origen();
            llenar_combo_destino();
            llenar_combo_servicio();            
        }

        private void button_guardar_Click(object sender, EventArgs e)
        {          
            //Int32 ciudad_origen_id = comboBox_origen.SelectedValue;  //ToDo: pasar a id
            //int ciudad_origen_id = Convert.ToInt32(comboBox_origen.SelectedValue);
            string ciudad_origen_id = comboBox_origen.Text.Trim();//ToDo: pasar a id 
            string ciudad_destino_id = comboBox_destino.Text.Trim();//ToDo: pasar a id 
            string servicio_id = comboBox_servicio.Text.Trim();     //ToDo: pasar a id
            string precio_pasaje = text_precio_pasaje.Text.Trim();
            string precio_encomienda = text_precio_encomienda.Text.Trim();

            string error_message = "";
                        
            //Validate: No vacios en el formulario
            if (ciudad_origen_id == string.Empty || ciudad_destino_id == string.Empty || servicio_id == string.Empty || precio_pasaje == string.Empty || precio_encomienda == string.Empty)
            {
                error_message += "Los campos del formulario no pueden estar vacios." + Environment.NewLine + Environment.NewLine;
            }
            else
            {
                //Validate: precios sean numeros
                float output1;
                double output2;
                bool a = float.TryParse(precio_pasaje, out output1);
                bool b = double.TryParse(precio_encomienda, out output2);
                if (false)
                {
                 //   error_message += "Los campos Precio deben ser numericos." + Environment.NewLine + Environment.NewLine;
                }

                //Validate: origen y destino diferentes
                if (ciudad_origen_id == ciudad_destino_id)
                {
                    error_message += "Los campos Ciudad Origen y Ciudad Destino deben ser diferentes." + Environment.NewLine + Environment.NewLine;
                }
                else
                {
                    //Validate: No guardar un ruta identica a otra
                    if (ruta_repetida(ciudad_origen_id, ciudad_destino_id, servicio_id))
                    {
                        error_message += "Ya exite una ruta identica a la ingresada.";
                    }
                }
            }            

            if (error_message != string.Empty) 
            {
                label_message.Text = "¡RUTA NO CREADA!" + Environment.NewLine + Environment.NewLine + error_message;
                label_message.Visible = true;
            } else
            {

                crear_ruta(ciudad_origen_id, ciudad_destino_id, servicio_id, precio_pasaje, precio_encomienda);
                
                MessageBox.Show("Ruta creada con exito.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //"Limpiar" comboboxes y textboxes
                label_message.Text = "";
                label_message.Visible = false;
                text_precio_pasaje.Text = "";
                text_precio_encomienda.Text = "";
            }
        }

        private void button_volver_Click(object sender, EventArgs e)
        {
            FormRuta ruta = new FormRuta();
            this.Hide();
            ruta.ShowDialog();
            ruta = (FormRuta)this.ActiveMdiChild;
        }

        private void llenar_combo_origen()
        {
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = Settings.Default.CadenaDeConexion;
  
            DataSet ds_ciudades = new DataSet();
            SqlDataAdapter da_ciudades = new SqlDataAdapter("SELECT CIUD_DETALLE, CIUD_ID FROM DJML.CIUDADES ORDER BY 1", conexion);
            da_ciudades.Fill(ds_ciudades, "DJML.CIUDADES");

            comboBox_origen.DataSource = ds_ciudades.Tables[0].DefaultView;
            comboBox_origen.DisplayMember = "CIUD_DETALLE";
            comboBox_origen.ValueMember = "CIUD_ID";
            comboBox_origen.SelectedItem = null;
            comboBox_origen.Text = null;
            comboBox_origen.DropDownStyle = ComboBoxStyle.DropDownList;

        }

        private void llenar_combo_destino()
        {
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = Settings.Default.CadenaDeConexion;

            DataSet ds_ciudades = new DataSet();
            SqlDataAdapter da_ciudades = new SqlDataAdapter("SELECT CIUD_DETALLE, CIUD_ID FROM DJML.CIUDADES ORDER BY 1", conexion);
            da_ciudades.Fill(ds_ciudades, "DJML.CIUDADES");

            comboBox_destino.DataSource = ds_ciudades.Tables[0].DefaultView;
            comboBox_destino.DisplayMember = "CIUD_DETALLE";
            comboBox_destino.ValueMember = "CIUD_ID";
            comboBox_destino.SelectedItem = null;
            comboBox_destino.Text = null;
            comboBox_destino.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void llenar_combo_servicio()
        {
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = Settings.Default.CadenaDeConexion;

            DataSet ds_servicios = new DataSet();
            SqlDataAdapter da_servicios = new SqlDataAdapter("SELECT SERV_DESCRIPCION, SERV_ID FROM DJML.SERVICIOS ORDER BY 1", conexion);
            da_servicios.Fill(ds_servicios, "DJML.SERVICIOS");

            comboBox_servicio.DataSource = ds_servicios.Tables[0].DefaultView;
            comboBox_servicio.DisplayMember = "SERV_DESCRIPCION";
            comboBox_servicio.ValueMember = "SERV_ID";
            comboBox_servicio.SelectedItem = null;
            comboBox_servicio.Text = null;
            comboBox_servicio.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private bool ruta_repetida(string origen, string destino, string servicio)
        {
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = Settings.Default.CadenaDeConexion;

            string qry = "select RUTA_CODIGO ruta_codigo, co.CIUD_DETALLE origen, cd.CIUD_DETALLE destino, s.SERV_DESCRIPCION servicio, r.RUTA_PRECIO_BASE_KILO precio_base_kilo, r.RUTA_PRECIO_BASE_PASAJE precio_base_pasaje" +
                        " from djml.RUTAS r" +
                        " join djml.TRAMOS t on r.RUTA_TRAMO = t.TRAMO_ID" +
                        " join djml.CIUDADES co on co.CIUD_ID = t.TRAMO_CIUDAD_ORIGEN" +
                        " join djml.CIUDADES cd on cd.CIUD_ID = t.TRAMO_CIUDAD_DESTINO" +
                        " join djml.SERVICIOS s on r.RUTA_SERVICIO = s.SERV_ID" +
                        " where co.CIUD_DETALLE like '%" + origen + "'" +
                        " and cd.CIUD_DETALLE like '%" + destino + "'" +
                        " and s.SERV_DESCRIPCION like '%" + servicio + "'" +
                        " and r.RUTA_IS_ACTIVE = 1";
                      
            var result = new Query(qry).ObtenerDataTable();
            return (result.Rows.Count != 0);
        }

        private void crear_ruta(string origen, string destino, string servicio, string precio_pasaje, string precio_encomienda) 
        {
            string select_tramo = "SELECT TRAMO_ID FROM djml.TRAMOS" +
                              " WHERE TRAMO_CIUDAD_ORIGEN = (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + origen + "')" +
                              " AND TRAMO_CIUDAD_DESTINO = (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + destino + "')";
            var result = new Query(select_tramo).ObtenerDataTable();

            if (result.Rows.Count == 0) {
                string insert_tramo = "INSERT INTO DJML.TRAMOS (TRAMO_CIUDAD_ORIGEN, TRAMO_CIUDAD_DESTINO)" +
                                     " SELECT (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + origen + "'), " +
                                            " (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + destino +"')";
                new Query(insert_tramo).Ejecutar();
            }

            string qry = "INSERT INTO DJML.RUTAS (RUTA_TRAMO, RUTA_SERVICIO, RUTA_PRECIO_BASE_PASAJE, RUTA_PRECIO_BASE_KILO, RUTA_IS_ACTIVE)" +
                            " select " +
                                " (SELECT TRAMO_ID FROM djml.TRAMOS" +
                                    " WHERE TRAMO_CIUDAD_ORIGEN = (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + origen + "')" +
                                    " AND TRAMO_CIUDAD_DESTINO = (SELECT CIUD_ID FROM djml.CIUDADES WHERE CIUD_DETALLE like '%" + destino + "')), " +
                                " SERV_ID, " + precio_pasaje + ", " + precio_encomienda + ", 1" +
                            " FROM djml.SERVICIOS WHERE SERV_DESCRIPCION like '%" + servicio + "'";


           new Query(qry).Ejecutar();
        }
    }
}
