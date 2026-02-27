using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VizsgaLib;

namespace VizsgaLib
{
    public partial class Hirdetes
    {
        public int Jutalek => (Dealer.Jutalek * Ar) / 100;
    }
}
