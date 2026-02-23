using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LolSupportLib
{
    public partial class Hibajegy
    {
        public int Pontszam
        {
            get
            {
                int pont = Sulyossag * 10;

                if (Hos != null && Hos.NyeresiArany > 52)
                {
                    pont += 5;
                }

                return pont;
            }
        }

        public string RovidLeiras
        {
            get
            {
                string szoveg = Leiras ?? "";
                return szoveg.Length <= 40 ? szoveg : szoveg.Substring(0, 40);
            }
        }
    }
}
