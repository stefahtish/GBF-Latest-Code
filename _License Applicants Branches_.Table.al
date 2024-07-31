table 50595 "License Applicants Branches"
{
    Caption = 'License Applicants Branches';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application no"; Code[20])
        {
            Caption = 'Application no';
            DataClassification = ToBeClassified;
        }
        field(2; Outlet; Code[100])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                AppProperOutlet: Record "Applicants Products per outlet";
                ApplProdAreaofSale: Record "Applicant product area of sale";
            begin
                if Outlet = '' then begin
                    AppProperOutlet.setrange(Outlet, rec.Outlet);
                    if AppProperOutlet.Find('-')then begin
                        AppProperOutlet.DeleteAll();
                        AppProperOutlet.Modify();
                    end;
                    ApplProdAreaofSale.setrange(Outlet, rec.Outlet);
                    if ApplProdAreaofSale.Find('-')then begin
                        ApplProdAreaofSale.DeleteAll();
                        ApplProdAreaofSale.Modify();
                    end;
                end;
            end;
        }
        field(3; "Category of outlets"; Text[100])
        {
            Caption = 'Category of Premise';
            DataClassification = ToBeClassified;
            TableRelation = "Means of Handling Setup" where("Means of Handling"=filter(Premise));
        }
        field(4; "Contact person"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Telephone No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; County; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(7; Subcounty; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code" where("County Code"=field(County));

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                subc.SetRange("Sub-County Code", Subcounty);
                if subc.find('-')then begin
                    "Sub-County Name":=subc.Name;
                    Station:=subc.Station;
                end;
            end;
        }
        field(8; "County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sub-County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Station; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Salutation;Enum Salutations)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Physical Location"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Application no", Outlet)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        AppProperOutlet: Record "Applicants Products per outlet";
        ApplProdAreaofSale: Record "Applicant product area of sale";
    begin
        if xrec.Outlet = '' then begin
            AppProperOutlet.setrange(Outlet, rec.Outlet);
            if AppProperOutlet.Find('-')then begin
                AppProperOutlet.DeleteAll();
                AppProperOutlet.Modify();
            end;
            ApplProdAreaofSale.setrange(Outlet, rec.Outlet);
            if ApplProdAreaofSale.Find('-')then begin
                ApplProdAreaofSale.DeleteAll();
                ApplProdAreaofSale.Modify();
            end;
        end;
        if Outlet = '' then begin
            AppProperOutlet.setrange(Outlet, rec.Outlet);
            if AppProperOutlet.Find('-')then begin
                AppProperOutlet.DeleteAll();
                AppProperOutlet.Modify();
            end;
            ApplProdAreaofSale.setrange(Outlet, rec.Outlet);
            if ApplProdAreaofSale.Find('-')then begin
                ApplProdAreaofSale.DeleteAll();
                ApplProdAreaofSale.Modify();
            end;
        end;
        AppProperOutlet.setrange(Outlet, rec.Outlet);
        if AppProperOutlet.Find('-')then begin
            AppProperOutlet.DeleteAll();
            AppProperOutlet.Modify();
        end;
        ApplProdAreaofSale.setrange(Outlet, rec.Outlet);
        if ApplProdAreaofSale.Find('-')then begin
            ApplProdAreaofSale.DeleteAll();
            ApplProdAreaofSale.Modify();
        end;
        AppProperOutlet.setrange(Outlet, Outlet);
        if AppProperOutlet.Find('-')then begin
            AppProperOutlet.DeleteAll();
            AppProperOutlet.Modify();
        end;
        ApplProdAreaofSale.setrange(Outlet, Outlet);
        if ApplProdAreaofSale.Find('-')then begin
            ApplProdAreaofSale.DeleteAll();
            ApplProdAreaofSale.Modify();
        end;
    end;
}
