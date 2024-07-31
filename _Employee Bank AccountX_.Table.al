table 50358 "Employee Bank AccountX"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Address; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Address 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code")then City:=PostCode.City;
            end;
        }
        field(10; Contact; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Telex No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Bank Branch No."; Text[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(14; "Bank Account No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Transit No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(17; "Country Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(18; County; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Telex Answer Back"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Language Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(22; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Home Page"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(25; "Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest, Up, Down;
        }
        field(26; "Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: 2;
        }
    }
    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var PostCode: Record "Post Code";
}
