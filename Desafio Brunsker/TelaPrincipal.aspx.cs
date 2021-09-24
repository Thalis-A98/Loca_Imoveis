using Desafio_Brunsker.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Desafio_Brunsker
{
    public partial class TelaPrincipal : System.Web.UI.Page
    {
        HttpClient client;
        Uri usuarioUri;

        public TelaPrincipal()
        {        

            if (client == null)
            {
                client = new HttpClient();
                client.BaseAddress = new Uri("https://viacep.com.br/ws/");
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string comando = @"select i.handle, i.rua, i.numero, i.bairro, i.cidade, i.estado, i.cep, ti.tipoImovel, i.qtdComodos, i.garagem,i.valorCondominio,i.valorAluguel, i.metrosQuadrados from imovel i
           inner join tipoimovel ti on ti.handle = i.tipoImovel";

            var tabelaImoveis = ConexaoMySql.ComandoComRetorno(comando);

            GridImoveis.DataSource = tabelaImoveis;
            GridImoveis.DataBind();

            for(int i = 0; i<GridImoveis.Rows.Count; i++ )
            {
                if (GridImoveis.Rows[i].Cells[9].Text == "True")
                {
                    GridImoveis.Rows[i].Cells[9].Text = "Sim";
                }
                else
                {
                    GridImoveis.Rows[i].Cells[9].Text = "Não";
                }
            }
        }

        protected void btnConfirmaBusca_Click(object sender, EventArgs e)
        {
            
        }
        private EnderecoViaCEP BuscarCep(string cep)
        {
            var endereco = new EnderecoViaCEP();

            //chamando a api pela url
            System.Net.Http.HttpResponseMessage response = client.GetAsync($"{cep}/json").Result;

            //se retornar com sucesso busca os dados
            if (response.IsSuccessStatusCode)
            {
                //pegando o cabeçalho
                usuarioUri = response.Headers.Location;

                //Pegando os dados do Rest e armazenando na variável usuários
                var jsonString = response.Content.ReadAsStringAsync().Result;

                JObject jsonResultadoObjeto = JObject.Parse(jsonString);

                endereco.Rua = (string)jsonResultadoObjeto["logradouro"];
                endereco.Bairro = (string)jsonResultadoObjeto["bairro"];
                endereco.Cidade = (string)jsonResultadoObjeto["localidade"];
                endereco.Estado = (string)jsonResultadoObjeto["uf"];
                endereco.CEP = (string)jsonResultadoObjeto["cep"];

            }

            //Se der erro na chamada, mostra o status do código de erro.
            else
            {
                Response.Write(response.StatusCode.ToString() + " - " + response.ReasonPhrase);
            }

            return endereco;
        }

        protected void btnCadastrar_Click1(object sender, EventArgs e)
        {

        }

        protected void btnEncontrarCEP_Click(object sender, EventArgs e)
        {
            if(txtCadastroCep.Text != string.Empty)
            {
                panelCadastro.Visible = true;
                var endereco = BuscarCep(txtCadastroCep.Text);
                txtRua.Text = endereco.Rua;
                txtBairro.Text = endereco.Bairro;
                txtCidade.Text = endereco.Cidade;
                txtEstado.Text = endereco.Estado;
                txtCep.Text = endereco.CEP;
            }

        }

        protected void btnCadastrar_Click(object sender, EventArgs e)
        {
            int temGaragem = ckGaragem.Checked ? 1 : 0;

            string comando = $@"insert into imovel (rua, numero, bairro, cidade, estado, cep, tipoImovel, qtdComodos, garagem, 
                                                            valorCondominio, valorAluguel, metrosQuadrados)
                                                    values('{txtRua.Text}','{txtNumero.Text}','{txtBairro.Text}','{txtCidade.Text}',
                                                            '{txtEstado.Text}','{txtCep.Text}','{ddlTipoImovel.SelectedValue}'
                                                            ,'{txtQtdComodos.Text}','{temGaragem}','{txtValorCondominio.Text}',
                                                            '{txtValorAluguel.Text}','{txtMetros.Text}')";

            ConexaoMySql.ComandoSemRetorno(comando);
            Response.Redirect(Request.RawUrl);
        }

        protected void GridImoveis_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "excluir")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridImoveis.Rows[index];
                var teste = GridImoveis.Rows[index].Cells[0].Text;
                int id = Convert.ToInt32(teste);

                ConexaoMySql.ComandoSemRetorno($"delete from imovel where handle = {id}");
                Response.Redirect(Request.RawUrl);
            }
            if(e.CommandName == "editar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridImoveis.Rows[index];
                var idGrid = GridImoveis.Rows[index].Cells[0].Text;
                int id = Convert.ToInt32(idGrid);

                string comando = $@"select i.handle, i.rua, i.numero, i.bairro, i.cidade, i.estado, i.cep, ti.tipoImovel, i.qtdComodos, i.garagem,i.valorCondominio,i.valorAluguel, i.metrosQuadrados from imovel i
                                inner join tipoimovel ti on ti.handle = i.tipoImovel
                                where i.handle = {id}";

                var dadosBanco = ConexaoMySql.ComandoComRetorno(comando);

                lblHandle.Text = idGrid;
                //txtEditaNumero.Text = dadosBanco.Rows[0]["numero"].ToString();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "ShowPopup();", true);
            }
        }

        protected void btnSalvarEdicao_Click(object sender, EventArgs e)
        {
            int temGaragem = ckGaragem.Checked ? 1 : 0;

            string comando = $@"UPDATE imovel SET numero = '{txtEditaNumero.Text}', qtdComodos = '{txtEditaqtdComodos.Text}',
                                garagem ='{temGaragem}', valorCondominio = '{txtEditaValorCondominio.Text}', 
                                valorAluguel = '{txtEditaValorAluguel.Text}',metrosQuadrados = '{txtEditaMetros.Text}'
                                WHERE handle = {lblHandle.Text} ";
            ConexaoMySql.ComandoSemRetorno(comando);
            Response.Redirect(Request.RawUrl);
        }
    }
}