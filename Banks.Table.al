table 50544 Banks
{
    DrillDownPageID = "Banks List";
    LookupPageID = "Banks List";

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Name; Text[250])
        {
        }
        field(3; Address; Text[30])
        {
        }
        field(4; "Address 2"; Text[30])
        {
        }
        field(5; City; Text[30])
        {
        }
        field(6; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Telex No.")then "Phone No.":=PostCode.City;
            end;
        }
        field(7; Contact; Text[30])
        {
        }
        field(8; "Phone No."; Text[30])
        {
        }
        field(9; "Telex No."; Text[20])
        {
        }
        field(10; "Bank No."; Text[20])
        {
            NotBlank = false;
        }
        field(11; "Bank Account No."; Text[30])
        {
        }
        field(12; "Transit No."; Text[20])
        {
        }
        field(13; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(14; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(15; County; Text[30])
        {
        }
        field(16; "Fax No."; Text[30])
        {
        }
        field(17; "Telex Answer Back"; Text[20])
        {
        }
        field(18; "Language Code"; Code[10])
        {
            TableRelation = Language;
        }
        field(19; "E-Mail"; Text[80])
        {
        }
        field(20; "Home Page"; Text[80])
        {
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(22; "Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest, Up, Down;
        }
        field(23; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 2: 2;
        }
        field(24; "Swift Code"; Code[20])
        {
            TableRelation = "SWIFT Code";
        }
        field(25; "Sort Code"; Code[50])
        {
        }
        field(26; "Non-bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Bank: Record Banks;
            begin
                if Bank.get("Bank Code")then;
                "Bank Code Name":=Bank.Name;
                "Swift Code":=Bank."Swift Code";
            end;
        }
        field(28; "Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                if BankBranches.get("Bank Code", "Bank Branch Code")then "Bank Branch Name":=BankBranches."Branch Name";
            end;
        }
        field(30; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Stima; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Post bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Payment Mode"; Code[20])
        {
            TableRelation = "Payment Method".Code;
        }
        field(35; Local; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var PostCode: Record "Post Code";
}
