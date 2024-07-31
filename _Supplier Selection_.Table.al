table 50416 "Supplier Selection"
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
            TableRelation = "Prequalified Suppliers".Name;
        }
        field(3; "Supplier Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
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
            TableRelation = "Prequalified Supplier Categ".Vendor WHERE("Category Code"=FIELD("Supplier Category"));

            // TableRelation = "EOI Evaluation Line"."Vendor No" where("Quote No" = field("Reference No."));
            trigger OnValidate()
            var
                lvRec: Record "Prospective Suppliers";
            begin
                lvRec.Reset();
                lvRec.SetRange("No.", "Supplier Code");
                if lvRec.FindFirst()then begin
                    "Supplier Name":=lvRec.Name;
                    Address:=lvRec."Physical Address";
                    City:=lvRec.City;
                    "Phone No.":=lvRec."Mobile No";
                    "Post Code":=lvRec."Post Code";
                    County:=lvRec.County;
                    "Country/Region Code":=lvRec."Country/Region Code";
                    "Supplier Email":=lvRec."E-Mail";
                //Contact := lvRec.cont;
                //TelephoneContact := lvRec."Primary Contact No.";
                end;
            end;
        }
        field(12; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Supplier Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Contact; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; TelephoneContact; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Reference No.", "Supplier Code", "Supplier Category")
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
    var ProcurementRequest: Record "Procurement Request";
    PostCode: Record "Post Code";
    Vendor: Record Vendor;
}
