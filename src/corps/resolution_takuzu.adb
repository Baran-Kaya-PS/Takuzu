pragma Ada_2012;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Text_IO; use ada.Text_IO;
with affichage;            use affichage;
package body Resolution_Takuzu is

   --------------------
   -- CompleterLigne --
   --------------------

   procedure CompleterLigne
     (G : in out Type_Grille; L : in Integer; V : in Type_Chiffre)
   is
      compteurChiffre : Integer;
      ligne: Type_Rangee;
      coord: Type_Coordonnee;
   begin
      compteurChiffre := 0;
      ligne:=extraireLigne(G,L);
      for i in 1..Taille(ligne) loop
         if ObtenirChiffre(ligne,i) = V then
            compteurChiffre := compteurChiffre + 1;
         end if;
      end loop;

      if compteurChiffre = Taille(ligne)/2 then
         for i in 1..Taille(G) loop
            coord:=ConstruireCoordonnees(L,i);
            if estCaseVide(G,coord) then
               G:=FixerChiffre(G, coord, Complement(V));
            end if;
         end loop;
      end if;
   end CompleterLigne;

   ----------------------
   -- CompleterColonne --
   ----------------------

   procedure CompleterColonne
     (G : in out Type_Grille; Col : in Integer; V : in Type_Chiffre)
   is
      compteurChiffre : Integer;
      colonne: Type_Rangee;
      coord: Type_Coordonnee;
   begin
      compteurChiffre := 0;
      colonne:=extraireColonne(G,Col);
      for i in 1..Taille(colonne) loop
         if ObtenirChiffre(colonne,i) = V then
            compteurChiffre := compteurChiffre + 1;
         end if;
      end loop;

      if compteurChiffre = Taille(colonne)/2 then
         for i in 1..Taille(G) loop
            coord:=ConstruireCoordonnees(i,Col);
            if estCaseVide(G,coord) then
               G:=FixerChiffre(G, coord, Complement(V));
            end if;
         end loop;
      end if;
   end CompleterColonne;

   --------------------
   -- ResoudreTakuzu --
   --------------------

   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean) is
      Placement: Type_Coordonnee;
      Ligne, Colonne: Type_Rangee;
      GrilleTemp: Type_Grille;
   begin
      -- Placement sur la premiere case
      Placement:=ConstruireCoordonnees(1,1);
      -- Initialisation de la grille temporaire
      GrilleTemp:=G;
      -- Tant que la grille n'est pas remplie faire
      while not (EstRemplie(G)) loop
         -- traitement de toutes les lignes
         for i in 1..Taille(G) loop
            Ligne:= extraireLigne(G, i);
            if not EstVide(Ligne) then
               -- Verifie si la ligne comporte deja la moitié d'un certain chiffre
               CompleterLigne(G, i, UN);
               CompleterLigne(G, i, ZERO);
               -- traitement de toutes les cases de la ligne en cours
               for j in 1..Taille(Ligne) loop
                  Placement:=ConstruireCoordonnees(i,j);
                  if estCaseVide(G, Placement) then
                     if SontDeuxChiffresDeDroiteEgaux(Ligne, j) then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeDroite(Ligne, j)));
                     elsif (j > 1) and then SontDeuxChiffresDeGaucheEgaux(Ligne, j) then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeGauche(Ligne, j)));
                     elsif (chiffreDeDroite(Ligne, j) = chiffreDeGauche(Ligne, j)) and chiffreDeDroite(Ligne, j) /= INCONNU then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeDroite(Ligne, j)));
                     end if;
                  end if;
               end loop;
            end if;
         end loop;
         -- traitement de toutes les colonnes
         for i in 1..Taille(G) loop
            Colonne:= extraireColonne(G, i);
            if not EstVide(Colonne) then
               -- Verifie si la colonne comporte deja la moitié d'un certain chiffre
               CompleterColonne(G, i, UN);
               CompleterColonne(G, i, ZERO);
               -- traitement de toutes les cases de la colonne en cours
               for j in 1..Taille(Colonne) loop
                  Placement:=ConstruireCoordonnees(j,i);
                  if estCaseVide(G, Placement) then
                     if SontDeuxChiffresDeDroiteEgaux(Colonne, j) then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeDroite(Colonne, j)));
                     elsif (j > 1) and then SontDeuxChiffresDeGaucheEgaux(Colonne, j) then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeGauche(Colonne, j)));
                     elsif (chiffreDeDroite(Colonne, j) = chiffreDeGauche(Colonne, j)) and chiffreDeDroite(Colonne, j) /= INCONNU then
                        G:=FixerChiffre(G, Placement, Complement(chiffreDeDroite(Colonne, j)));
                     end if;
                  end if;
               end loop;
            end if;
         end loop;
         -- Si la grille n'a pas changé, alors on fait par forcage brute
         if GrilleTemp = G then
            G:=retourSurTrace(G);
         end if;
         -- Vérifie si la grille est remplie
         if EstRemplie(G) then
            Trouve := True;
         else
            Trouve := False;
         end if;
         -- Copie de la grille dans la grille temporaire
         GrilleTemp:=G;
      end loop;
   end ResoudreTakuzu;

end Resolution_Takuzu;
