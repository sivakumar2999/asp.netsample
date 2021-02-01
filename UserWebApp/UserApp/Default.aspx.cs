using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserApp
{
    public partial class _Default : Page
    {
        string constr = @"Data Source=(localdb)\ProjectsV13;Initial Catalog=UserManagement;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearData();
        }

       

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectData();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DeleteData(e.RowIndex);
          this.BindGrid();
         }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SaveData();
            this.BindGrid();
        }

        private void ClearData()
        {
            txtAge.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            DropDownSex.SelectedValue = "";
            hUserid.Value = "0";
        }

        private void BindGrid()
        {

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Users_GetAll"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();

                        }
                    }
                }
            }

        }

        private void SelectData()
        {
            ClearData();
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Users_Get"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserId", GridView1.SelectedValue);

                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            foreach (DataRow row in dt.Rows)
                            {
                                txtAge.Text = row["age"].ToString();
                                txtFirstName.Text = row["firstname"].ToString();
                                txtLastName.Text = row["lastname"].ToString();
                                DropDownSex.SelectedValue = row["sex"].ToString();
                                hUserid.Value = row["userid"].ToString();
                            }
                        }
                    }
                }
            }
        }
        private void DeleteData(int RowIndex)
        {

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Users_Delete"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", GridView1.DataKeys[RowIndex].Values[0]);

                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            ClearData();
        }

        private void SaveData()
        {
            string SPName = "Users_Insert";
            if (hUserid.Value != "0") { SPName = "Users_Update"; }
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(SPName))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", hUserid.Value);
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Age", txtAge.Text.Trim());
                    cmd.Parameters.AddWithValue("@Sex", DropDownSex.SelectedValue);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            ClearData();
        }

        protected void txtFirstName_TextChanged(object sender, EventArgs e)
        {

        }
    }
}