using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Data;
using System.Web.Configuration;
using System.Linq;
using System.Web.Services;
using System.Web.Script.Services;

public partial class AddEmployee : System.Web.UI.Page
{

    //declare constants
    const double employeeFee = 1000.00;
    const double dependentFee = 500.00;
    const double discountRate = .10;
    const double paycheckTotal = 2000.00;
    const bool roundUp = false;
    string firstChar = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //display gridview on page load.
            SetInitialRow();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //add dependent to Gridview
        var first = txtDepFirstName.Text;
        var last = txtDepLastname.Text;
        var relation = ddDepRelation.SelectedValue;
        AddNewRowToGrid(first, last, relation);
        txtDepFirstName.Text = "";
        txtDepLastname.Text = "";
        ddDepRelation.ClearSelection();
        //ddDepRelation.SelectedIndex = ddDepRelation.Items.IndexOf(ddDepRelation.Items.FindByValue(""));
    }

    private void SetInitialRow()
    {
        //This sets up the gridview and displays it on page load as an empty table. The empty row will be removed once a dependent is added.
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("Row Number", typeof(string)));
        dt.Columns.Add(new DataColumn("First Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Last Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Relation", typeof(string)));
       
        dr = dt.NewRow();
        dr["Row Number"] = string.Empty;
        dr["First Name"] = string.Empty;
        dr["Last Name"] = string.Empty;
        dr["Relation"] = string.Empty;
        dt.Rows.Add(dr);
        dr = dt.NewRow();
        //Store the DataTable in ViewState
        ViewState["CurrentTable"] = dt;
        gdvDepList.DataSource = dt;
        gdvDepList.DataBind();
        
        //hides row number column
        if (gdvDepList.Columns.Count > 0)
            gdvDepList.Columns[0].Visible = false;
        else
        {
            gdvDepList.HeaderRow.Cells[0].Visible = false;
            foreach (GridViewRow gvr in gdvDepList.Rows)
            {
                gvr.Cells[0].Visible = false;
                gvr.Cells[3].Visible = false;
            }
        }
        Calculate();
    }

    protected Boolean IsPopulated(String row)
    {

        return !row.Equals(string.Empty);
    }

    private void AddNewRowToGrid(string first, string last, string relation)
    {
        if (ViewState["CurrentTable"] != null)
        {
            //add new dependent to gridview
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable.Rows.Count > 0)
            {
                //remove empty row once a record is added
                if (dtCurrentTable.Rows[0]["Row Number"].Equals(""))
                {
                    dtCurrentTable.Rows.Remove(dtCurrentTable.Rows[0]);
                    dtCurrentTable.Columns.Add("Delete", typeof(Button));
                }

                drCurrentRow = dtCurrentTable.NewRow();
                drCurrentRow["Row Number"] = dtCurrentTable.Rows.Count + 1;
                drCurrentRow["First Name"] = first;
                drCurrentRow["Last Name"] = last;
                drCurrentRow["Relation"] = relation;

                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable"] = dtCurrentTable;
                gdvDepList.DataSource = dtCurrentTable;
                gdvDepList.DataBind();

                if (gdvDepList.Columns.Count > 0)
                    gdvDepList.Columns[0].Visible = false;
                else
                {
                    gdvDepList.HeaderRow.Cells[0].Visible = false;
                    foreach (GridViewRow gvr in gdvDepList.Rows)
                    {
                        gvr.Cells[0].Visible = false;
                    }
                }
                Calculate();
            }
        }
    }

    protected void gdv_RowDeleted(object sender, GridViewDeletedEventArgs e) {
    }
    protected void gdv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

        if (dtCurrentTable.Rows.Count > 0)
        {
            dtCurrentTable.Rows[e.RowIndex].Delete();
            ViewState["CurrentTable"] = dtCurrentTable;
            gdvDepList.DataSource = dtCurrentTable;
            gdvDepList.DataBind();
            if (dtCurrentTable.Rows.Count <= 0)
                SetInitialRow();
        }
        Calculate();
    }

    protected void NameChanged(object sender, EventArgs e)
    {
        var first = txtFirstName.Text.Substring(0, 1);
        if (!first.Equals(firstChar))
        {
            firstChar = first;
            Calculate();
        }

    }

    private void Calculate()
    {
        //declare calculated variables
        double calculatedEmpFee = 0.00;
        double calculatedDepFee = 0.00;
        double paycheckFee = 0.00;
        double paycheckDiscounts = 0.00;
        double paycheckAfterFee = 0.00;
        double annualTotal = 0.00;
        double annualFee = 0.00;
        double annualDiscounts = 0.00;
        double annualAfterFee = 0.00;
        int dependentCount = 0;
        bool employeeDiscount = false;
        string employeeName = string.Empty;

        //get employee first name and determine if discount should be applied.
        employeeName = txtFirstName.Text;
        //employeeDiscount = 
        
        if(employeeName != string.Empty)
        employeeDiscount = employeeName.Substring(0, 1).ToUpper().Equals("A");

         
        if (employeeDiscount)
        {
            calculatedEmpFee = employeeFee - (employeeFee * discountRate);
            annualDiscounts = employeeFee - calculatedEmpFee;
        }
        else
            calculatedEmpFee = employeeFee;

        //get dependent information and determine if discounts should be applied
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

            if (dtCurrentTable.Rows.Count > 0)
            {
                var numDiscounts = 0;
                dependentCount = dtCurrentTable.Rows.Count;
                foreach (DataRow dr in dtCurrentTable.Rows)
                {
                    if (dr["First Name"].ToString() != string.Empty)
                    {
                        if (dr["First Name"].ToString().Substring(0, 1).ToUpper().Equals("A"))
                        {
                            numDiscounts += 1;
                            annualDiscounts += dependentFee * discountRate;
                        }
                        calculatedDepFee = (dependentFee * dependentCount) - (dependentFee * (numDiscounts * discountRate));
                    }                   
                }
            }
        }

        //calculate remaining values
        annualTotal = paycheckTotal * 26;
        annualFee = calculatedEmpFee + calculatedDepFee;
        annualAfterFee = annualTotal - annualFee;
        paycheckFee = annualFee / 26;
        paycheckAfterFee = annualAfterFee / 26;
        paycheckDiscounts = annualDiscounts / 26;

        //round calculations to 2 decimal places
        paycheckFee = Math.Round(paycheckFee, 2);
        paycheckDiscounts = Math.Round(paycheckDiscounts, 2);
        paycheckAfterFee = Math.Round(paycheckAfterFee, 2);
        annualFee = Math.Round(annualFee, 2);
        annualDiscounts = Math.Round(annualDiscounts, 2);
        annualAfterFee = Math.Round(annualAfterFee, 2);
        
        //Update Labels to newest values
        lblPaycheckGross.Text = "$" + paycheckTotal;
        lblPaycheckDue.Text = "$" + paycheckFee;
        lblPaycheckDiscount.Text = "$" + paycheckDiscounts;
        lblPaycheckNet.Text = "$" + paycheckAfterFee;
        lblAnnualGross.Text = "$" + annualTotal;
        lblAnnualDue.Text = "$" + annualFee;
        lblAnnualDiscount.Text = "$" + annualDiscounts;
        lblAnnualNet.Text = "$" + annualAfterFee;
    }

}