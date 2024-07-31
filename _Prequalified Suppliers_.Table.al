table 50140 "Prequalified Suppliers"
{
    fields
    {
        field(1; "Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Postal Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "E-mail"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Telephone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Mobile No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contact Person"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "KBA Bank Code"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Bank AccountX".Code;
        }
        field(11; "KBA Branch Code"; Code[3])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Bank AccountX"."Bank Branch No." WHERE(Code=FIELD("KBA Bank Code"));
        }
        field(12; "Bank account No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(14; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Pre Qualified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Fax No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Category Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Incorporation Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Company PIN No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Vendor No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No")then begin
                    Name:=Vendor.Name;
                    "Physical Address":=Vendor.Address;
                    "Postal Address":=Vendor.Address;
                    City:=Vendor.City;
                    "E-mail":=Vendor."E-Mail";
                    "Telephone No":=Vendor."Phone No.";
                    "Fax No":=Vendor."Fax No.";
                    "Fax No.":=Vendor."Fax No.";
                    "Country/Region Code":=Vendor."Country/Region Code";
                    "Post Code":=Vendor."Post Code";
                end;
            end;
        }
        field(22; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "  ", Medical, Law;
        }
        field(23; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Approved,Closed';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected, Approved, Closed;
        }
        field(24; Attachment; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = ToBeClassified;
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(27; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode(City, "Post Code", County, "Country/Region Code");
                if "Country/Region Code" <> xRec."Country/Region Code" then;
            //  VATRegistrationValidation;
            end;
        }
        field(28; County; Text[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(29; "Sub County"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Contract Period");
            end;
        }
        field(31; "Contract Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Contract Start Date" <> 0D then "Contract End Date":=CalcDate("Contract Period", "Contract Start Date");
            end;
        }
        field(32; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; BeneFiciaryGroup; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'women,Youth,People With Disabilities,General';
            OptionMembers = women, Youth, "People With Disabilities", General;
        //to be changed to agpo details
        //when general  is slected block agpo nu
        }
        field(34; "KRA PIN"; Text[30])
        {
            Caption = 'KRA PIN';
            DataClassification = ToBeClassified;
        }
        field(35; "AGPO NO."; Text[30])
        {
            Caption = 'AGPO NO.';
            DataClassification = ToBeClassified;
        }
        field(36; "Name of Director"; Text[50])
        {
            Caption = 'Name of Director';
            DataClassification = ToBeClassified;
        }
        field(37; "Tax Compliance"; Code[50])
        {
            Caption = 'Tax Compliance No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Vendor No", Name, Category, "Fiscal Year")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Vendor: Record Vendor;
    PostCode: Record "Post Code";
    procedure CreateVend(var Prequalifiedlist: Record "Prequalified Suppliers")
    var
        Vend: Record Vendor;
        CategoryRec: Record "Supplier Category";
    begin
        Prequalifiedlist.TestField(Prequalifiedlist."Company PIN No");
        Vend.SetCurrentKey("KRA PIN");
        Vend.SetRange(Vend."KRA PIN", Prequalifiedlist."Company PIN No");
        if Vend.FindFirst then Error('The Vendor %1 PIN No %2 already exists in the system', Vend.Name, Vend."KRA PIN");
        Vend.Init;
        Vend."No.":='';
        Vend.Name:=Prequalifiedlist.Name;
        Vend.Address:=Prequalifiedlist."Physical Address";
        Vend."Address 2":=Prequalifiedlist."Postal Address";
        Vend."E-Mail":=Prequalifiedlist."E-mail";
        Vend."Phone No.":=Prequalifiedlist."Telephone No";
        Vend."Telex No.":=Prequalifiedlist."Mobile No";
        Vend.Contact:=Prequalifiedlist."Contact Person";
        //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
        //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
        Vend."Our Account No.":=Prequalifiedlist."Bank account No";
        //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
        Vend."KRA PIN":=Prequalifiedlist."Company PIN No";
        //Vend.v:=Prequalifiedlist."Registration No";
        if CategoryRec.Get(Prequalifiedlist.Category)then begin
            Vend."Gen. Bus. Posting Group":=CategoryRec."Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group":=CategoryRec."VAT Bus. Posting Group";
            Vend."Vendor Posting Group":=CategoryRec."Vendor Posting Group";
        end;
        Vend.Insert(true);
        Prequalifiedlist."Vendor No":=Vend."No.";
        Prequalifiedlist.Modify;
    end;
    Var AgpoVisible: boolean;
}
