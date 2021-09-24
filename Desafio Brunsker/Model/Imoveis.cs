using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Desafio_Brunsker
{
    public class Imoveis
    {
        public int handle { get; set; }
        public string rua { get; set; }
        public string numero { get; set; }
        public string bairro { get; set; }
        public string cidade { get; set; }
        public string estado { get; set; }
        public int cep { get; set; }
        public int tipoImovel { get; set; }
        public int qtdComodos { get; set; }
        public bool garagem { get; set; }
        public double valorCondominio { get; set; }
        public double valorAluguel { get; set; }
        public int metrosQuadrados { get; set; }

    }
}