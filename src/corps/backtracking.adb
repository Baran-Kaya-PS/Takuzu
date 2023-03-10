pragma Ada_2012;

package body backtracking is

   --------------------
   -- GrilleCorrecte --
   --------------------

   function GrilleCorrecte (G: in Type_Grille) return Boolean is
      Ligne: Type_Rangee;
      NbUn, NbZero: Integer;
   begin
      -- Verifie les lignes
      for i in 1..Taille(G) loop
         Ligne:=extraireLigne(G, i);
         NbUn:=0;
         NbZero:=0;
         for y in 1..Taille(Ligne) loop
            -- Verifie si la ligne comporte plus de la moitie de 1 ou de 0
            if ObtenirChiffre(Ligne, y) = UN then
               NbUn := NbUn + 1;
            elsif ObtenirChiffre(Ligne, y) = ZERO then
               NbZero := NbZero + 1;
            end if;
            if NbUn > (Taille(Ligne)/2) or NbZero > (Taille(G)/2) then
               return False;
            end if;
            -- Verifie si il y a 3 chiffres aligne
            if y > 1 and y < Taille(Ligne) then
               if ObtenirChiffre(Ligne, y) /= INCONNU
                 and ObtenirChiffre(Ligne, y-1) = ObtenirChiffre(Ligne, y)
                 and ObtenirChiffre(Ligne, y) = ObtenirChiffre(Ligne, y+1) then
                  return False;
               end if;
            end if;
          end loop;
      end loop;
      -- Verifie pour les colonnes
      for i in 1..Taille(G) loop
         Ligne:=extraireColonne(G, i);
         NbUn:=0;
         NbZero:=0;
         for y in 1..Taille(Ligne) loop
            -- Verifie si la colonne comporte plus de la moitie de 1 ou de 0
            if ObtenirChiffre(Ligne, y) = UN then
               NbUn := NbUn + 1;
            elsif ObtenirChiffre(Ligne, y) = ZERO then
               NbZero := NbZero + 1;
            end if;
            if NbUn > (Taille(Ligne)/2) or NbZero > (Taille(G)/2) then
               return False;
            end if;
            -- Verifie si il y a 3 chiffres aligne
            if y > 1 and y < Taille(Ligne) then
               if ObtenirChiffre(Ligne, y) /= INCONNU
                 and ObtenirChiffre(Ligne, y-1) = ObtenirChiffre(Ligne, y)
                 and ObtenirChiffre(Ligne, y) = ObtenirChiffre(Ligne, y+1) then
                  return False;
               end if;
            end if;
          end loop;
      end loop;
      return True;
   end grilleCorrecte;

   --------------------
   -- retourSurTrace --
   --------------------

   function retourSurTrace (G : in Type_Grille) return Type_Grille is
      resolu: boolean;
      GrilleResolue: Type_Grille;
      Coord: Type_Coordonnee;
      Ligne: Type_Rangee;
      ListeCoor, CasesRemplie: Type_Pile;
   begin
      ListeCoor:=construirePile;
      -- Extraction de toutes les coordonnees des cases vides/inconnues
      -- dans la pile ListeCoor
      for i in 1..Taille(G) loop
         Ligne:=extraireLigne(G, i);
         for y in 1..Taille(Ligne) loop
            if EstInconnue(ObtenirChiffre(Ligne, y)) then
               Coord:=ConstruireCoordonnees(i, y);
               ListeCoor:=empiler(ListeCoor, Coord);
            end if;
         end loop;
      end loop;
      -- Initialisation de la pile casesRemplie qui contiendra les cases
      -- auquels on a deja attribue une valeur
      casesRemplie:=construirePile;
      -- Copie de la grille G
      GrilleResolue:=G;
      -- Initialisation des coordonnees de la premiere case vide
      Coord:=dernier(ListeCoor);
      -- Placement d'un zero dans cette case
      GrilleResolue:=FixerChiffre(GrilleResolue, Coord, ZERO);
      -- On depile la liste des coordonnees des cases vides puisqu'on a deja remplie la premiere case
      casesRemplie:=empiler(CasesRemplie, dernier(ListeCoor));
      ListeCoor:=depiler(ListeCoor);
      -- Resolu sera faux tant que la grille correcte n'est pas trouvee
      resolu:=false;
      -- Ouverture de la boucle
      while not resolu loop
         -- Verifie si la grille est correcte
         if GrilleCorrecte(GrilleResolue) then
            -- si il reste des elements dans la pile de coordonnees des cases vides alors
            -- on passe a la coordonnee suivante
            if not estVide(ListeCoor) then
               Coord:=dernier(ListeCoor);
               CasesRemplie:=empiler(casesRemplie, dernier(ListeCoor));
               ListeCoor:=depiler(ListeCoor);
               GrilleResolue:=FixerChiffre(GrilleResolue, Coord, ZERO);
            else
               -- si la pile est vide, alors toutes les solutions ont été parcourues,
               -- donc resolu devient vrai et on quitte la boucle
               resolu:=True;
            end if;
         else
            -- Si la case actuelle vaut 0, on lui attribue 1
            if ValeurChiffre(ObtenirChiffre(GrilleResolue, Coord)) = 0 then
               GrilleResolue:=ViderCase(GrilleResolue, Coord);
               GrilleResolue:=FixerChiffre(GrilleResolue, Coord, UN);
            else
               -- Sinon, tant que les cases sont egales a 1, on depile la liste des cases remplies
               -- tout en les vidant
               GrilleResolue:= ViderCase(GrilleResolue, Coord);
               ListeCoor:= empiler(ListeCoor, dernier(casesRemplie));
                     Casesremplie:= depiler(casesRemplie);
               while ValeurChiffre(ObtenirChiffre(GrilleResolue, dernier(casesRemplie))) = 1 loop
                  GrilleResolue:=ViderCase(GrilleResolue, dernier(casesRemplie));
                     ListeCoor:= empiler(ListeCoor, dernier(casesRemplie));
                     Casesremplie:= depiler(casesRemplie);

               end loop;
               Coord:= dernier(casesRemplie);
               GrilleResolue:=ViderCase(GrilleResolue, Coord);
               GrilleResolue:=FixerChiffre(GrilleResolue, Coord, UN);
            end if;
         end if;
      end loop;
      return GrilleResolue;
   end retourSurTrace;

end backtracking;
