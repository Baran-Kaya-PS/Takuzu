pragma Ada_2012;
package body Grille is

   ----------------------
   -- ConstruireGrille --
   ----------------------

   function ConstruireGrille (T : Integer) return Type_Grille is
      G : Type_Grille;
   begin
      G.Taille := T;
      for i in 1..G.Taille loop
         for j in 1..G.Taille loop
            G.G(i,j):= INCONNU;
         end loop;
      end loop;
      return G;
   end ConstruireGrille;

   ------------
   -- Taille --
   ------------

   function Taille (G : in Type_Grille) return Integer is
   begin
      return G.Taille;
   end Taille;

   -----------------
   -- estCaseVide --
   -----------------

   function estCaseVide
     (G : in Type_Grille; C : in Type_Coordonnee) return Boolean
   is
   begin

      if G.G(ObtenirLigne(C), ObtenirColonne(C)) = INCONNU then
         return True;
      else
         return False;
      end if;
   end estCaseVide;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Chiffre
   is
   begin
      return G.G (ObtenirLigne(C), ObtenirColonne(C));
   end ObtenirChiffre;

   --------------------------
   -- NombreChiffresConnus --
   --------------------------

   function NombreChiffresConnus (G : in Type_Grille) return Integer is
      compteur : Integer;
   begin
      compteur := 0;
      for i in 1..G.Taille loop
         for j in 1..G.Taille loop
            if G.G (i,j) /= INCONNU then
               compteur := compteur + 1;
            end if;
         end loop;
      end loop;
      return compteur;
   end NombreChiffresConnus;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (G : in Type_Grille) return Boolean is
   begin
      return NombreChiffresConnus(G) = G.Taille*G.Taille;
   end EstRemplie;

   -------------------
   -- extraireLigne --
   -------------------

   function extraireLigne
     (G : in Type_Grille; L : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R:= ConstruireRangee(G.Taille);
      for i in 1..G.Taille loop
         R:=AjouterChiffre(R, i, G.G(L,i));
      end loop;
      return R;
   end extraireLigne;

   ---------------------
   -- extraireColonne --
   ---------------------

   function extraireColonne
     (G : in Type_Grille; C : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R:= ConstruireRangee(G.Taille);
      for i in 1..G.Taille loop
         R:=AjouterChiffre(R, i, G.G(i,C));
      end loop;
      return R;
   end extraireColonne;

   ------------------
   -- FixerChiffre --
   ------------------

   function FixerChiffre
     (G : in Type_Grille; C : in Type_Coordonnee; V : in Type_Chiffre)
      return Type_Grille
   is
      grille: Type_Grille;
   begin
      if not estCaseVide(G,C) then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;

      grille:=G;
      grille.G(ObtenirLigne(C),ObtenirColonne(C)):=V;
      return grille;
   end FixerChiffre;

   ---------------
   -- ViderCase --
   ---------------

   function ViderCase
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Grille
   is
      grille:Type_Grille;
   begin
      if estCaseVide(G,C) then
         raise VIDER_CASE_VIDE;
      end if;

      grille:=G;
      grille.G(ObtenirLigne(C),ObtenirColonne(C)):=INCONNU;
      return grille;
   end ViderCase;

end Grille;
