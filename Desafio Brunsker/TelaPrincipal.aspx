<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TelaPrincipal.aspx.cs" Inherits="Desafio_Brunsker.TelaPrincipal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <link href="style.css" rel="stylesheet" />
</head>
<body>
    <header>
        <h1>Loca Imóveis</h1>
    </header>
    <form id="form1" runat="server">
        <aside id="menuEsquerda">
            <h4 style="text-align: center;">Cadastrar novo Imóvel</h4>
            <div class="informacoes">
                <div class="mb-3">
                    <label>Informe o CEP do novo Imóvel:</label>
                    <asp:TextBox class="form-control" ID="txtCadastroCep" runat="server" placeholder="CEP" />
                </div>
                <div class="mb-3">
                    <asp:Button AutoPostBack="True" class="btn btn-dark" ID="btnEncontrarCEP" Text="Encontrar" runat="server" OnClick="btnEncontrarCEP_Click" />
                </div>

            </div>
            <asp:Panel runat="server" ID="panelCadastro" Visible="false">
                <div class="mb-3">
                    <label>Rua:</label>
                    <asp:TextBox ID="txtRua" runat="server" class="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>Número:</label>
                    <asp:TextBox ID="txtNumero" runat="server" class="form-control" placeholder="Número" />
                </div>
                <div class="mb-3">
                    <label>Bairro:</label>
                    <asp:TextBox ID="txtBairro" runat="server" class="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>Cidade:</label>
                    <asp:TextBox ID="txtCidade" runat="server" class="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>Estado:</label>
                    <asp:TextBox ID="txtEstado" runat="server" class="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>CEP:</label>
                    <asp:TextBox ID="txtCep" runat="server" class="form-control" ReadOnly="true" />
                </div>
                <div class="mb-3">
                    <label>Tipo Imóvel</label>
                    <asp:DropDownList ID="ddlTipoImovel" class="form-control" runat="server">
                        <asp:ListItem Text="Casa" Value="1" />
                        <asp:ListItem Text="Casa Geminada" Value="2" />
                        <asp:ListItem Text="Apartamento" Value="3" />
                        <asp:ListItem Text="Sitio" Value="4" />
                        <asp:ListItem Text="Kitnet" Value="5" />
                        <asp:ListItem Text="Flat" Value="6" />
                        <asp:ListItem Text="Sobrado" Value="7" />
                        <asp:ListItem Text="Bangalô" Value="8" />
                        <asp:ListItem Text="Studio" Value="9" />
                    </asp:DropDownList>
                </div>
                <div class="mb-3">
                    <label>Quantidade de Cômodos:</label>
                    <asp:TextBox ID="txtQtdComodos" runat="server" class="form-control" />
                </div>
                <div class="mb-3">
                    <asp:CheckBox ID="ckGaragem" Text="Possui garagem" runat="server" />
                </div>
                <div class="mb-3">
                    <label>Valor Condominio:</label>
                    <asp:TextBox ID="txtValorCondominio" runat="server" class="form-control" />
                </div>
                <div class="mb-3">
                    <label>Valor Aluguel:</label>
                    <asp:TextBox ID="txtValorAluguel" runat="server" class="form-control" />
                </div>
                <div class="mb-3">
                    <label>Metros Quadrados:</label>
                    <asp:TextBox ID="txtMetros" runat="server" class="form-control" />
                </div>
                <div class="mb-3">
                    <asp:Button ID="btnCadastrar" class="btn btn-dark" Text="Cadastrar" runat="server" OnClick="btnCadastrar_Click" />
                </div>
            </asp:Panel>
        </aside>
        <aside id="dataGridView">
            <asp:GridView ID="GridImoveis" runat="server" AutoGenerateColumns="false"
                AlternatingRowStyle-BackColor="#c0c0c0"
                HeaderStyle-BackColor="#666666" OnRowCommand="GridImoveis_RowCommand">
                <Columns>
                    <asp:BoundField DataField="handle" HeaderText="Código" />
                    <asp:BoundField DataField="rua" HeaderText="Rua" ApplyFormatInEditMode="true" />
                    <asp:BoundField DataField="numero" HeaderText="Número" HeaderStyle-Width="220px" />
                    <asp:BoundField DataField="bairro" HeaderText="Bairro" />
                    <asp:BoundField DataField="cidade" HeaderText="Cidade" />
                    <asp:BoundField DataField="estado" HeaderText="Estado" />
                    <asp:BoundField DataField="cep" HeaderText="CEP" />
                    <asp:BoundField DataField="tipoImovel" HeaderText="Tipo Imóvel" />
                    <asp:BoundField DataField="qtdComodos" HeaderText="Quantidade Cômodos" />
                    <asp:BoundField DataField="garagem" HeaderText="Possui Garagem" />
                    <asp:BoundField DataField="valorCondominio" HeaderText="Valor Condominio" />
                    <asp:BoundField DataField="valorAluguel" HeaderText="Valor Aluguel" />
                    <asp:BoundField DataField="metrosQuadrados" HeaderText="Metros Quadrados" />
                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Img/IconeEditar.svg" CommandName="editar" />
                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Img/IconeExcluir.svg" CommandName="excluir" />
                </Columns>
            </asp:GridView>
        </aside>
        <!-- Button trigger modal -->

        <a href="#" runat="server" style="display: none" id="btnAbrirModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">abrir modal</a>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Editar Imóvel</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label runat="server" ID="lblHandle" Visible="false" />
                        <div class="mb-3">
                            <label>Número:</label>
                            <asp:TextBox ID="txtEditaNumero" runat="server" class="form-control"  />
                        </div>
                        <div class="mb-3">
                            <label>Quantidade de Cômodos:</label>
                            <asp:TextBox ID="txtEditaqtdComodos" runat="server" class="form-control" /><br />
                        </div>
                        <div class="mb-3">
                            <asp:CheckBox ID="ckEditaGaragem" Text="Possui garagem" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label>Valor Condominio:</label>
                            <asp:TextBox ID="txtEditaValorCondominio" runat="server" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label>Valor Aluguel:</label>
                            <asp:TextBox ID="txtEditaValorAluguel" runat="server" class="form-control" />
                        </div>
                        <div class="mb-3">
                            <label>Metros Quadrados:</label>
                            <asp:TextBox ID="txtEditaMetros" runat="server" class="form-control" /><br />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                        <asp:Button ID="btnSalvarEdicao" Text="Salvar" class="btn btn-primary" runat="server" OnClick="btnSalvarEdicao_Click" />
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function ShowPopup() {

                var btnAbrirModal = document.getElementById('btnAbrirModal');
                btnAbrirModal.click();

            }
          </script>
    </form>

</body>
</html>
