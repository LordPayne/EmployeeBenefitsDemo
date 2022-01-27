<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEmployee.aspx.cs" Inherits="AddEmployee" %>
<!DOCTYPE html>
<html lang = "en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add Employee Benefits</title>
    <script src="https://ajax.microsoft.com/ajax/jquery/jquery-3.6.0.js" type="text/javascript"></script>     
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link href="dist/css/modern.css" rel="stylesheet">
    <script src="dist/js/settings.js"></script>
    <style>
      body {
      opacity: 0;
      }
      .user-icon {
      height: 2rem !important;
      width: 2rem !important;
      margin: .5rem;
      }
      .user-icon {
      height: 2rem !important;
      width: 2rem !important;
      margin: .5rem;
      }
      .select2-selection {
      -webkit-box-shadow: 0;
      box-shadow: 0;
      background-color: #fff;
      border: 0;
      border-radius: 0;
      color: #555555;
      font-size: 14px;
      outline: 0;
      min-height: 48px;
      text-align: left;
      padding-left:0px;
      width:100%;
      }
      .select2-selection__rendered {
      margin: 10px;
      padding-left:0px !important;
      }
      .select2-selection__arrow {
      margin: 10px;
      }
      .border{
      border: 1px solid black;
      border-radius: 5px;
      margin:5px;
      }
      .textbox{
      width: 200px;
      height: auto;
      }
      .cell
      {
      text-align:left;
      }
      .righttextbox
      {
      float:right;
      }
    </style>
    <script type="text/javascript">
        function toggleMenu() {
            if ($('#sidebar').hasClass("hidden")) {
                $('#sidebar').removeClass("hidden");
            } else {
                $('#sidebar').addClass("hidden");
            }
        }     
    </script>
      <script type="text/javascript">
          function textChanged() {
              $.ajax({
                  type: "POST",
                  url: "moves.aspx/textChanged",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (doc) {
                  },
                  error: function (xhr, status, error) {
                      console.log('textChanged Failed');
                      alert(xhr.responseText);
                  }
                  });
          }
      </script>
  </head>
  <body>
    <form runat="server">
      <div class="wrapper">
        <nav id="sidebar" class="sidebar"
          >
          <a class="sidebar-brand" href="index.html">
          <i class="fa fa-users-cog fa-2x"></i><span style="font-size: .9em">HR Central</span>
          </a>
          <div class="sidebar-content" style="border-right: 1px solid gray;">           
            <ul class="sidebar-nav">
              <li class="sidebar-item">
                  <a href="AddEmployee.aspx" class="sidebar-link">
                <i class="align-middle me-2 fas fa-fw fa-list"></i><span class="align-middle">Add Employee to Benefits</span>
                </a>
                <a href="ViewBenefits.aspx" class="sidebar-link">
                <i class="align-middle me-2 fas fa-fw fa-list"></i><span class="align-middle">View Employee Benefits</span>
                </a>
              </li>
            </ul>
          </div>
        </nav>
        <div class="main">
          <nav class="navbar navbar-expand navbar-theme">
            <a id="navtoggle"class="sidebar-toggle d-flex me-2" onclick="toggleMenu()">
            <i class="hamburger align-self-center"></i>
            </a>
          </nav>
          <main class="content">
            <div class="container-fluid">
              <div class="header">
                <h1 class="header-title">Add Employee To Benefits
                </h1>
              </div>
              <div class="row">
                <div class="col-12 col-lg-12 d-flex">
                  <div class="card flex-fill">
                    <div class="row">
                      <div id="data" class="col-7 col-lg-67 d-flex row ms-1">
                        <div class="card-header">
                          <div class="card-actions float-end">
                            <a href="#" class="me-1">
                            <i class="align-middle" data-feather="refresh-cw"></i>
                            </a>
                          </div>
                          <h3 class="font-weight-bold">Employee Information</h3>
                        </div>
                        <div class="p-3">
                          <div class="mb-3">
                            <span class="">First Name</span><br />
                            <div style="width: 200px;">
                              <asp:TextBox ID="txtFirstName" CssClass="form-control" class="textbox" style="height:auto;" runat="server" 
                                  onchange="$.ajax({type: 'GET', url: 'AddEmployee.aspx/textChanged',contentType: 'application/json; charset=utf-8',dataType: 'json',success: function (doc) {console.log('Epic Success');},error: function (xhr, status, error) {console.log('Epic Fail');alert(xhr.responseText);}}); });"
                                  OnTextChanged="NameChanged" AutoCompleteType="Disabled" ></asp:TextBox>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Last Name</span><br />
                            <div style="width: 200px;">
                              <asp:TextBox ID="txtLastName" CssClass="form-control" class="textbox" style="height:auto;" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                          </div>
                        </div>
                        <div class="card-header">
                          <div class="card-actions float-end">
                            <a href="#" class="me-1">
                            <i class="align-middle" data-feather="refresh-cw"></i>
                            </a>
                          </div>
                          <h3 class="font-weight-bold">Dependents</h3>
                        </div>
                        <div class="mb-3" style="display:inline-block">
                          <table>
                            <tr id="dependent">
                              <td>
                                <asp:Label ID="lblDepFirstName" runat="server" Text="First Name: "></asp:Label>
                              </td>
                              <td style="width: 4px">&nbsp;</td>
                              <td>
                                <asp:TextBox ID="txtDepFirstName" CssClass="form-control" class="textbox" style="height:auto;" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                              </td>
                              <td style="width: 8px">&nbsp;</td>
                              <td>
                                <asp:Label ID="lblDepLastName" runat="server" Text="Last Name: "></asp:Label>
                              </td>
                              <td style="width: 4px">&nbsp;</td>
                              <td>
                                <asp:TextBox ID="txtDepLastname" CssClass="form-control" class="textbox" style="height:auto;" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                              </td>
                              <td style="width: 8px">&nbsp;</td>
                              <td>
                                <asp:Label ID="lblDepRelation" runat="server" Text="Relation: "></asp:Label>
                              </td>
                              <td style="width: 4px">&nbsp;</td>
                              <td>
                                <asp:DropDownList id="ddDepRelation"
                                  AutoPostBack="True"
                                  runat="server">
                                  <asp:ListItem  Value=""> </asp:ListItem>
                                  <asp:ListItem  Value="Spouse"> Spouse </asp:ListItem>
                                  <asp:ListItem Value="Child"> Child </asp:ListItem>
                                </asp:DropDownList>
                              </td>
                              <td style="width: 12px">&nbsp;</td>
                              <td>
                                <asp:Button ID="btnAddDep" runat="server" Text="Add" class="textbox" onclick="btnSubmit_Click" CssClass="btn btn-primary w-10" UseSubmitBehavior="true"/>
                              </td>
                            </tr>
                          </table>
                        </div>
                        <div class="mb-3">
                          <asp:GridView ID="gdvDepList" runat="server"
                            CssClass="table table-striped"
                            UseAccessibleHeader="true"
                            GridLines="None"
                            Style="width: 505px;"
                            autogeneratecolumns = false
                            OnRowDeleted="gdv_RowDeleted"
                            OnRowDeleting="gdv_RowDeleting">
                            <emptydatatemplate>No data found</emptydatatemplate>
                            <Columns>
                              <asp:BoundField DataField="Row Number" HeaderText="Row Number"/>
                              <asp:BoundField DataField="First Name" HeaderText="First Name" />
                              <asp:BoundField DataField="Last Name" HeaderText="Last Name" />
                              <asp:BoundField DataField="Relation" HeaderText="Relation" />
                              <asp:TemplateField>
                                <ItemTemplate>
                                  <asp:Button runat="server" Text="Delete" 
                                    Visible='<%# IsPopulated((String)Eval("Row Number")) %>' 
                                    CommandName="Delete"/>
                                </ItemTemplate>
                              </asp:TemplateField>
                            </Columns>
                          </asp:GridView>
                        </div>
                      </div>
                      <div id="spacer" class="col-2 col-lg-2 d-flex row">
                      </div>
                      <div id="calculations" class="col-3 col-lg-3 d-flex row border">
                        <div class="card-header">
                          <div class="card-actions float-end">
                            <a href="#" class="me-1">
                            <i class="align-middle" data-feather="refresh-cw"></i>
                            </a>
                          </div>
                          <h3 class="mb-0 font-weight-bold">Payroll Breakout</h3>
                        </div>
                        <div class="p-3">
                          <div class="mb-3">
                            <span class="">Paycheck Gross:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblPaycheckGross" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Paycheck Deductions:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblPaycheckDue" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Paycheck Discount:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblPaycheckDiscount" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Paycheck Net:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblPaycheckNet" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Annual Gross:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblAnnualGross" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Annual Deductions:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblAnnualDue" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Annual Discount:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblAnnualDiscount" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <span class="">Annual Net:</span><br />
                            <div style="width: 200px;">
                              <asp:Label ID="lblAnnualNet" runat="server" Text="$0"></asp:Label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </main>
        </div>
      </div>
        <script>
            $(function () {
                $("#<%=ddDepRelation.ClientID%>").select2({
                    placeholder: "*",
                    selectOnClose: false
                });
            });            
        </script>
    </form>
  </body>
</html>