﻿namespace AerolineaFrba.Login_Usuario
{
    partial class FormLogin
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtUsu = new System.Windows.Forms.TextBox();
            this.txtPassw = new System.Windows.Forms.TextBox();
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.bnSalir = new System.Windows.Forms.Button();
            this.bnAceptar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(35, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(46, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Usuario:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(35, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Password:";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // txtUsu
            // 
            this.txtUsu.Location = new System.Drawing.Point(105, 21);
            this.txtUsu.Name = "txtUsu";
            this.txtUsu.Size = new System.Drawing.Size(100, 20);
            this.txtUsu.TabIndex = 2;
            this.txtUsu.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // txtPassw
            // 
            this.txtPassw.Location = new System.Drawing.Point(105, 57);
            this.txtPassw.Name = "txtPassw";
            this.txtPassw.Size = new System.Drawing.Size(100, 20);
            this.txtPassw.TabIndex = 3;
            // 
            // linkLabel1
            // 
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Location = new System.Drawing.Point(119, 89);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.Size = new System.Drawing.Size(60, 13);
            this.linkLabel1.TabIndex = 4;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "Registrarse";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel1_LinkClicked);
            // 
            // bnSalir
            // 
            this.bnSalir.Location = new System.Drawing.Point(38, 120);
            this.bnSalir.Name = "bnSalir";
            this.bnSalir.Size = new System.Drawing.Size(75, 23);
            this.bnSalir.TabIndex = 5;
            this.bnSalir.Text = "Salir";
            this.bnSalir.UseVisualStyleBackColor = true;
            this.bnSalir.Click += new System.EventHandler(this.bnSalir_Click);
            // 
            // bnAceptar
            // 
            this.bnAceptar.Location = new System.Drawing.Point(130, 120);
            this.bnAceptar.Name = "bnAceptar";
            this.bnAceptar.Size = new System.Drawing.Size(75, 23);
            this.bnAceptar.TabIndex = 6;
            this.bnAceptar.Text = "Aceptar";
            this.bnAceptar.UseVisualStyleBackColor = true;
            this.bnAceptar.Click += new System.EventHandler(this.bnAceptar_Click);
            // 
            // FormLogin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(226, 152);
            this.Controls.Add(this.bnAceptar);
            this.Controls.Add(this.bnSalir);
            this.Controls.Add(this.linkLabel1);
            this.Controls.Add(this.txtPassw);
            this.Controls.Add(this.txtUsu);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "FormLogin";
            this.Text = "FormLogin";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtUsu;
        private System.Windows.Forms.TextBox txtPassw;
        private System.Windows.Forms.LinkLabel linkLabel1;
        private System.Windows.Forms.Button bnSalir;
        private System.Windows.Forms.Button bnAceptar;
    }
}