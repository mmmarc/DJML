﻿namespace AerolineaFrba.Generacion_Viaje
{
    partial class FormGenerarViaje
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormGenerarViaje));
            this.button2 = new System.Windows.Forms.Button();
            this.fechaSalida = new System.Windows.Forms.DateTimePicker();
            this.fechaLlegadaEstimada = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.comboBoxAeronaves = new System.Windows.Forms.ComboBox();
            this.SELECCIONAR = new System.Windows.Forms.DataGridViewButtonColumn();
            this.CIUDAD_ORIGEN = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CIUDAD_DESTINO = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.bnBuscar = new System.Windows.Forms.Button();
            this.datos = new System.Windows.Forms.DataGridView();
            this.boton = new System.Windows.Forms.DataGridViewButtonColumn();
            ((System.ComponentModel.ISupportInitialize)(this.datos)).BeginInit();
            this.SuspendLayout();
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(175, 365);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(94, 44);
            this.button2.TabIndex = 1;
            this.button2.Text = "Volver";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // fechaSalida
            // 
            this.fechaSalida.Location = new System.Drawing.Point(185, 31);
            this.fechaSalida.Name = "fechaSalida";
            this.fechaSalida.Size = new System.Drawing.Size(218, 20);
            this.fechaSalida.TabIndex = 2;
            this.fechaSalida.ValueChanged += new System.EventHandler(this.fechaSalida_ValueChanged);
            // 
            // fechaLlegadaEstimada
            // 
            this.fechaLlegadaEstimada.Location = new System.Drawing.Point(185, 62);
            this.fechaLlegadaEstimada.Name = "fechaLlegadaEstimada";
            this.fechaLlegadaEstimada.Size = new System.Drawing.Size(218, 20);
            this.fechaLlegadaEstimada.TabIndex = 4;
            this.fechaLlegadaEstimada.ValueChanged += new System.EventHandler(this.fechaLLegadaEstimada_ValueChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(34, 31);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(69, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Fecha Salida";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(34, 62);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(128, 13);
            this.label3.TabIndex = 7;
            this.label3.Text = "Fecha LLegada Estimada";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(34, 131);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(112, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Seleccionar Aeronave";
            // 
            // comboBoxAeronaves
            // 
            this.comboBoxAeronaves.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBoxAeronaves.FormattingEnabled = true;
            this.comboBoxAeronaves.Location = new System.Drawing.Point(185, 131);
            this.comboBoxAeronaves.Name = "comboBoxAeronaves";
            this.comboBoxAeronaves.Size = new System.Drawing.Size(218, 21);
            this.comboBoxAeronaves.TabIndex = 9;
            this.comboBoxAeronaves.SelectedIndexChanged += new System.EventHandler(this.comboBoxAeronaves_SelectedIndexChanged);
            // 
            // SELECCIONAR
            // 
            this.SELECCIONAR.HeaderText = "SELECCIONAR";
            this.SELECCIONAR.Name = "SELECCIONAR";
            // 
            // CIUDAD_ORIGEN
            // 
            this.CIUDAD_ORIGEN.HeaderText = "CIUDAD_ORIGEN";
            this.CIUDAD_ORIGEN.Name = "CIUDAD_ORIGEN";
            // 
            // CIUDAD_DESTINO
            // 
            this.CIUDAD_DESTINO.HeaderText = "CIUDAD_DESTINO";
            this.CIUDAD_DESTINO.Name = "CIUDAD_DESTINO";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(37, 163);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(92, 13);
            this.label5.TabIndex = 11;
            this.label5.Text = "Seleccionar Ruta:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(34, 101);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(97, 13);
            this.label6.TabIndex = 12;
            this.label6.Text = "Buscar Aeronaves:";
            // 
            // bnBuscar
            // 
            this.bnBuscar.Location = new System.Drawing.Point(185, 101);
            this.bnBuscar.Name = "bnBuscar";
            this.bnBuscar.Size = new System.Drawing.Size(218, 23);
            this.bnBuscar.TabIndex = 13;
            this.bnBuscar.Text = "Buscar";
            this.bnBuscar.UseVisualStyleBackColor = true;
            this.bnBuscar.Click += new System.EventHandler(this.button3_Click);
            // 
            // datos
            // 
            this.datos.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
            this.datos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.datos.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.boton});
            this.datos.Location = new System.Drawing.Point(37, 192);
            this.datos.Name = "datos";
            this.datos.Size = new System.Drawing.Size(381, 150);
            this.datos.TabIndex = 14;
            this.datos.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick_3);
            // 
            // boton
            // 
            this.boton.HeaderText = "Seleccionar";
            this.boton.Name = "boton";
            this.boton.ReadOnly = true;
            this.boton.Text = "Seleccionar";
            // 
            // FormGenerarViaje
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.MintCream;
            this.ClientSize = new System.Drawing.Size(446, 421);
            this.Controls.Add(this.datos);
            this.Controls.Add(this.bnBuscar);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.comboBoxAeronaves);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.fechaLlegadaEstimada);
            this.Controls.Add(this.fechaSalida);
            this.Controls.Add(this.button2);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FormGenerarViaje";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Generar Viaje";
            this.Load += new System.EventHandler(this.FormGenerarViaje_Load_1);
            ((System.ComponentModel.ISupportInitialize)(this.datos)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.DateTimePicker fechaSalida;
        private System.Windows.Forms.DateTimePicker fechaLlegadaEstimada;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox comboBoxAeronaves;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DataGridViewButtonColumn SELECCIONAR;
        private System.Windows.Forms.DataGridViewTextBoxColumn CIUDAD_ORIGEN;
        private System.Windows.Forms.DataGridViewTextBoxColumn CIUDAD_DESTINO;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button bnBuscar;
        private System.Windows.Forms.DataGridView datos;
        private System.Windows.Forms.DataGridViewButtonColumn boton;
    }
}