using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using VizsgaLib;

namespace ScheduleGUI
{
    public class MainWindowViewModel : INotifyPropertyChanged
    {
        // (1.) INotifyPropertyChanged generált sora, context és választott dolgok megírása + Notify metódus:

        private readonly ScheduleiContext context = new();
        private Dealer? valasztottDealer;
        private Hirdetes? valasztottHirdetes;
        public event PropertyChangedEventHandler? PropertyChanged;
        public void Notify([CallerMemberName] string propName = "")
        => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));

        // (2.) A két combo box listájának elkészítése:

        public List<Dealer> Dealerek { get; init; }
        public ObservableCollection<Hirdetes> AktivHirdetesek { get; init; }

        // (6.) Első Combobox get és set jének megírása

        public Dealer? ValasztottDealer
        {
            get => valasztottDealer!;
            set
            {
                valasztottDealer = value;
                AktivHirdetesek.Clear();
                ValasztottHirdetes = null;

                if (valasztottDealer != null)
                {
                    var hirdetesek = context.Hirdetes
                        .Where(x => x.DealerId == valasztottDealer.DealerId && x.Meddig == null)
                        .Include(x => x.Termek)
                        .ThenInclude(x => x.Kategoria)
                        .Include(x => x.Dealer)
                        .OrderBy(x => x.Termek.Nev)
                        .ToList();

                    foreach(var item in hirdetesek)
                    {
                        AktivHirdetesek.Add(item);
                    }

                    Notify(nameof(AktivHirdetesek));
                    Notify(nameof(VanDealer));
                    Notify(nameof(AdatokVisible));
                }
            }
        }
        // (7.) Második Combobox get és set jének megírása

        public Hirdetes? ValasztottHirdetes
        {
            get => valasztottHirdetes!;
            set
            {
                valasztottHirdetes = value;
                if(valasztottHirdetes != null)
                {
                    KategoriaNev = valasztottHirdetes.Termek.Kategoria.Megnevezes;
                    ThcSzazalek = valasztottHirdetes.Termek.ThcSzazalek;
                    Ar = valasztottHirdetes.Ar;
                    Jutalek = valasztottHirdetes.Jutalek;
                }
                Notify(nameof(ValasztottHirdetes));
                Notify(nameof(KategoriaNev));
                Notify(nameof(ThcSzazalek));
                Notify(nameof(Ar));
                Notify(nameof(Jutalek));
                Notify(nameof(AdatokVisible));
            }
        }

        // (3.) Kiirandó elemek felvétele:

        public string KategoriaNev { get; set; } = "";
        public int ThcSzazalek { get; set; }
        public int Ar {  get; set; }
        public int Jutalek { get; set; }

        // (4.) Láthatósághoz szükséges adatok felvétele

        public bool VanDealer => valasztottDealer != null;
        public Visibility AdatokVisible => valasztottHirdetes != null ? Visibility.Visible : Visibility.Hidden;

        // (5.) Comboboxok feltöltése:

        public MainWindowViewModel()
        {
            Dealerek = context.Dealers
                .OrderBy(x=>x.Nev)
                .ToList();

            AktivHirdetesek = new ObservableCollection<Hirdetes>();
        }
    }
}
