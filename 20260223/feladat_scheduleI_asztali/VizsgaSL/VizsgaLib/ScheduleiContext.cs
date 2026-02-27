using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace VizsgaLib;

public partial class ScheduleiContext : DbContext
{
    public ScheduleiContext()
    {
    }

    public ScheduleiContext(DbContextOptions<ScheduleiContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Dealer> Dealers { get; set; }

    public virtual DbSet<Hirdetes> Hirdetes { get; set; }

    public virtual DbSet<Kategoria> Kategoria { get; set; }

    public virtual DbSet<Termek> Termeks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySql("database=schedulei;server=127.0.0.1;uid=root;pwd=root_p_ssW0rd;port=3306", Microsoft.EntityFrameworkCore.ServerVersion.Parse("9.3.0-mysql"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_hungarian_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Dealer>(entity =>
        {
            entity.HasKey(e => e.DealerId).HasName("PRIMARY");

            entity.ToTable("dealer");

            entity.Property(e => e.DealerId).HasColumnName("dealer_id");
            entity.Property(e => e.Jutalek).HasColumnName("jutalek");
            entity.Property(e => e.Nev)
                .HasMaxLength(50)
                .HasColumnName("nev");
            entity.Property(e => e.Terulet)
                .HasMaxLength(40)
                .HasColumnName("terulet");
        });

        modelBuilder.Entity<Hirdetes>(entity =>
        {
            entity.HasKey(e => e.HirdetesId).HasName("PRIMARY");

            entity.ToTable("hirdetes");

            entity.HasIndex(e => e.DealerId, "FK_Hirdetes_Dealer");

            entity.HasIndex(e => e.TermekId, "FK_Hirdetes_Termek");

            entity.Property(e => e.HirdetesId).HasColumnName("hirdetes_id");
            entity.Property(e => e.Ar).HasColumnName("ar");
            entity.Property(e => e.DealerId).HasColumnName("dealer_id");
            entity.Property(e => e.Meddig).HasColumnName("meddig");
            entity.Property(e => e.Mennyiseg).HasColumnName("mennyiseg");
            entity.Property(e => e.Mikortol).HasColumnName("mikortol");
            entity.Property(e => e.TermekId).HasColumnName("termek_id");

            entity.HasOne(d => d.Dealer).WithMany(p => p.Hirdetes)
                .HasForeignKey(d => d.DealerId)
                .HasConstraintName("FK_Hirdetes_Dealer");

            entity.HasOne(d => d.Termek).WithMany(p => p.Hirdetes)
                .HasForeignKey(d => d.TermekId)
                .HasConstraintName("FK_Hirdetes_Termek");
        });

        modelBuilder.Entity<Kategoria>(entity =>
        {
            entity.HasKey(e => e.KategoriaId).HasName("PRIMARY");

            entity.ToTable("kategoria");

            entity.Property(e => e.KategoriaId).HasColumnName("kategoria_id");
            entity.Property(e => e.Megnevezes)
                .HasMaxLength(50)
                .HasColumnName("megnevezes");
        });

        modelBuilder.Entity<Termek>(entity =>
        {
            entity.HasKey(e => e.TermekId).HasName("PRIMARY");

            entity.ToTable("termek");

            entity.HasIndex(e => e.KategoriaId, "FK_Termek_Kategoria");

            entity.Property(e => e.TermekId).HasColumnName("termek_id");
            entity.Property(e => e.KategoriaId).HasColumnName("kategoria_id");
            entity.Property(e => e.Leiras)
                .HasMaxLength(255)
                .HasColumnName("leiras");
            entity.Property(e => e.Nev)
                .HasMaxLength(50)
                .HasColumnName("nev");
            entity.Property(e => e.ThcSzazalek).HasColumnName("thc_szazalek");

            entity.HasOne(d => d.Kategoria).WithMany(p => p.Termeks)
                .HasForeignKey(d => d.KategoriaId)
                .HasConstraintName("FK_Termek_Kategoria");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
