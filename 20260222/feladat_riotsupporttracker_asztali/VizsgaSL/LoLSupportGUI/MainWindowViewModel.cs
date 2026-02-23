using Microsoft.EntityFrameworkCore;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using LolSupportLib;

namespace LoLSupportGUI;

public class MainWindowViewModel : INotifyPropertyChanged
{
    readonly LolSupportContext context = new();

    private Ugyintezo? valasztottUgyintezo;
    private Hibajegy? valasztottHibajegy;

    public event PropertyChangedEventHandler? PropertyChanged;
    void Notify([CallerMemberName] string prop = "")
        => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));

    public List<Ugyintezo> Ugyintezok { get; init; }
    public ObservableCollection<Hibajegy> Hibajegyek { get; init; } = new();

    public bool VanHibajegy => Hibajegyek.Count != 0;

    // Kijelzett adatok
    public string HosNev { get; set; } = "";
    public string Statusz { get; set; } = "";
    public int Sulyossag { get; set; }
    public int Pontszam { get; set; }
    public string Datum { get; set; } = "";
    public string Leiras { get; set; } = "";

    public Visibility AdatokVisible => valasztottHibajegy == null ? Visibility.Hidden : Visibility.Visible;

    public Ugyintezo? ValasztottUgyintezo
    {
        get => valasztottUgyintezo;
        set
        {
            valasztottUgyintezo = value;

            Hibajegyek.Clear();

            if (valasztottUgyintezo != null)
            {
                foreach (var h in context.Hibajegies
                    .Include(x => x.Hos)
                    .Where(x => x.UgyintezoId == valasztottUgyintezo.UgyintezoId
                             && (x.Statusz == "open" || x.Statusz == "investigating"))
                    .OrderBy(x => x.Datum))
                {
                    Hibajegyek.Add(h);
                }
            }

            valasztottHibajegy = null;

            Notify(nameof(VanHibajegy));
            Notify(nameof(AdatokVisible));
        }
    }

    public Hibajegy? ValasztottHibajegy
    {
        get => valasztottHibajegy;
        set
        {
            valasztottHibajegy = value;

            if (valasztottHibajegy != null)
            {
                var h = context.Hibajegies
                    .Include(x => x.Hos)
                    .First(x => x.HibajegyId == valasztottHibajegy.HibajegyId);

                HosNev = h.Hos == null ? "-" : h.Hos.Nev!;
                Statusz = h.Statusz ?? "";
                Sulyossag = h.Sulyossag;
                Pontszam = h.Pontszam;
                Datum = h.Datum.ToString("yyyy.MM.dd");
                Leiras = h.Leiras ?? "";
            }

            Notify(nameof(HosNev));
            Notify(nameof(Statusz));
            Notify(nameof(Sulyossag));
            Notify(nameof(Pontszam));
            Notify(nameof(Datum));
            Notify(nameof(Leiras));
            Notify(nameof(AdatokVisible));
        }
    }

    public MainWindowViewModel()
    {
        Ugyintezok = [.. context.Ugyintezos.OrderBy(x => x.Nev)];
    }
}