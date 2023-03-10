pragma Ada_2012;
package body Coordonnee is

   ---------------------------
   -- ConstruireCoordonnees --
   ---------------------------
   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee
   is
      C : Type_Coordonnee;
   begin
      C.Ligne := Ligne;
      C.Colonne := Colonne;
      return C;
   end ConstruireCoordonnees;

   ------------------
   -- ObtenirLigne --
   ------------------
   function ObtenirLigne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Ligne;
   end ObtenirLigne;

   --------------------
   -- ObtenirColonne --
   --------------------
   function ObtenirColonne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Colonne;
   end ObtenirColonne;

   ----------
   -- Haut --
   ----------
   function Haut (C : in Type_Coordonnee) return Type_Coordonnee is
      nvlC: Type_Coordonnee;
   begin
      nvlC.Ligne := C.Ligne - 1;
      nvlC.Colonne := C.Colonne;
      return nvlC;
   end Haut;

   ---------
   -- Bas --
   ---------
   function Bas (C : in Type_Coordonnee) return Type_Coordonnee is
      nvlC: Type_Coordonnee;
   begin
      nvlC.Ligne := C.Ligne + 1;
      nvlC.Colonne := C.Colonne;
      return nvlC;
   end Bas;

   ------------
   -- Droite --
   ------------
   function Droite (C : in Type_Coordonnee) return Type_Coordonnee is
      nvlC : Type_Coordonnee;
   begin
      nvlC.Ligne := C.Ligne;
      nvlC.Colonne := C.Colonne + 1;
      return nvlC;
   end Droite;

   ------------
   -- Gauche --
   ------------
   function Gauche (C : in Type_Coordonnee) return Type_Coordonnee is
       nvlC : Type_Coordonnee;
   begin
      nvlC.Ligne := C.Ligne;
      nvlC.Colonne := C.Colonne - 1;
      return nvlC;
   end gauche;
end Coordonnee;
