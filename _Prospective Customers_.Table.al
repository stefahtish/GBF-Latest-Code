table 50444 "Prospective Customers"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Disposal";
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

            trigger OnValidate()
            begin
                MailMgt.CheckValidEmailAddress("E-mail");
            end;
        }
        field(7; "Telephone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Mobile No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "KBA Bank Code"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;
        }
        field(11; "KBA Branch Code"; Code[3])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("KBA Bank Code"));
        }
        field(12; "Bank account No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; County; Text[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(14; "Sub County"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; ApplicationDate; Date)
        {
        }
        field(17; "Country/Region Code"; Code[10])
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
        field(18; "Fax No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Customer No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Customer No")then begin
                    Name:=Customer.Name;
                    "Physical Address":=Customer.Address;
                    "Postal Address":=Customer.Address;
                    City:=Customer.City;
                    "E-mail":=Customer."E-Mail";
                    "Telephone No":=Customer."Phone No.";
                    "Fax No":=Customer."Fax No.";
                    "Fax No.":=Customer."Fax No.";
                    "Country/Region Code":=Customer."Country/Region Code";
                    "Post Code":=Customer."Post Code";
                end;
            end;
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
        field(27; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name)
        {
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        if "No." = '' then begin
            PurchSetup.TestField("Prospective Suppliers Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Prospective Suppliers Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        ApplicationDate:=Today;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    Vendor: Record Vendor;
    PostCode: Record "Post Code";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SupEvaLine: Record "Supplier Evaluation Line";
    TenderRec: Record "Procurement Request";
    TenderLine: Record "Procurement Request Lines";
    ProspectiveSupplierLine: Record "Prospective Supplier Line";
    MailMgt: Codeunit "Mail Management";
    ProspectiveRec: Record "Prospective Suppliers";
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
    procedure CreateVendr(var Prequalifiedlist: Record "Prospective Suppliers"): Code[50]var
        Vend: Record Vendor;
        CategoryRec: Record "Supplier Category";
        PSetup: Record "Purchases & Payables Setup";
    begin
        PSetup.get;
        PSetup.TestField("Def Gen. Bus. Posting Group");
        PSetup.TestField("Default Vendor Posting Group");
        Prequalifiedlist.TestField(Prequalifiedlist."Company PIN No.");
        Vend.Reset();
        Vend.SetRange(Vend."KRA PIN", Prequalifiedlist."Company PIN No.");
        if Vend.FindFirst then exit(Vend."No.")
        else
        begin
            Vend.Init;
            Vend."No.":='';
            Vend.Name:=Prequalifiedlist.Name;
            Vend.Address:=Prequalifiedlist."Physical Address";
            Vend."Address 2":=Prequalifiedlist."Postal Address";
            Vend."E-Mail":=Prequalifiedlist."E-mail";
            Vend."Phone No.":=Prequalifiedlist."Telephone No";
            Vend."Telex No.":=Prequalifiedlist."Mobile No";
            Vend.Contact:=Prequalifiedlist."Contact Person Name";
            //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
            //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
            Vend."Our Account No.":=Prequalifiedlist."Bank account No";
            //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
            Vend."KRA PIN":=Prequalifiedlist."Company PIN No.";
            //Vend.v:=Prequalifiedlist."Registration No";
            Vend."Vendor Posting Group":=PSetup."Default Vendor Posting Group";
            Vend."Gen. Bus. Posting Group":=PSetup."Def Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group":=PSetup."Def VAT Bus. Posting Group";
            /*if CategoryRec.Get(Prequalifiedlist.Category) then begin
                Vend."Gen. Bus. Posting Group" := CategoryRec."Gen. Bus. Posting Group";
                Vend."VAT Bus. Posting Group" := CategoryRec."VAT Bus. Posting Group";
                Vend."Vendor Posting Group" := CategoryRec."Vendor Posting Group";
            end;*/
            Vend."PIN Certificate Expiry":=Prequalifiedlist."PIN Certificate Expiry";
            Vend.Insert(true);
            Prequalifiedlist."Vendor No":=Vend."No.";
            Prequalifiedlist.Modify;
            exit(Vend."No.");
        end;
    end;
}
