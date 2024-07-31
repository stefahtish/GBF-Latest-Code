table 50414 "Bidders Selection"
{
    fields
    {
        field(1; "Reference No."; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";

            trigger OnValidate()
            begin
                if ProcurementRequest.Get("Reference No.")then begin
                    "Supplier Category":=ProcurementRequest.Category;
                end;
            end;
        }
        field(2; "Supplier Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Supplier Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Invited; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
            //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;
            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", false);
            end;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
            //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", false);
            end;
        }
        field(9; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(10; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Supplier Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Prospective Suppliers";
            TableRelation = "Prospective Supplier Tender"."Prospect No." WHERE("Tender No."=field("Reference No."));
        }
        field(12; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Supplier Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Supplier"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Prospective Supplier Tender"."Prospect No." WHERE("Tender No."=field("Reference No."));

            trigger OnValidate()
            var
                BiddersSelc: Record "Bidders Selection";
            begin
                BiddersSelc.Reset();
                BiddersSelc.SetRange(Supplier, Rec.Supplier);
                BiddersSelc.SetRange("Reference No.", Rec."Reference No.");
                if BiddersSelc.FindFirst()then Error('A supplier can only be selected once for this tender!');
                if ProSupplrs.Get(Supplier)then begin
                    "Supplier Name":=ProSupplrs.Name;
                    Address:=ProSupplrs."Physical Address";
                    City:=ProSupplrs.City;
                    "Phone No.":=ProSupplrs."Telephone No";
                    "Post Code":=ProSupplrs."Post Code";
                    County:=ProSupplrs.County;
                    "Country/Region Code":=ProSupplrs."Country/Region Code";
                    "Supplier Email":=ProSupplrs."E-Mail";
                // "Supplier Code" := ProSuppTend."Prospect No.";
                end;
            end;
        }
        field(15; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Passed Preliminary"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Reference No.", "Supplier Code", "Supplier Category", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Supplier Code", "Supplier Name")
        {
        }
    }
    trigger OnInsert()
    begin
        IntRecord();
    end;
    procedure IntRecord()
    var
        BSelection: Record "Bidders Selection";
    begin
        if not("Line No." = 0)then exit;
        BSelection.Reset();
        BSelection.SetCurrentKey("Line No.");
        BSelection.SetFilter("Reference No.", '%1', Rec."Reference No.");
        if BSelection.FindLast()then "Line No.":=BSelection."Line No." + 1000
        else
            "Line No.":=1000;
    end;
    var ProcurementRequest: Record "Procurement Request";
    ProSupplrs: Record "Prospective Suppliers";
    PostCode: Record "Post Code";
    Vendor: Record Vendor;
    ProSuppTend: Record "Prospective Supplier Tender";
}
