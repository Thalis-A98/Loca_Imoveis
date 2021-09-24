using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Desafio_Brunsker.Model
{
    public class EnderecoViaCEP
    {
        public string CEP { get; set; }
        public string Rua { get; set; }
        public string Bairro { get; set; }
        public string Cidade { get; set; }
        public string Estado { get; set; }
    }
}