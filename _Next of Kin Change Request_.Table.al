table 50275 "Next of Kin Change Request"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Relative Code"; Code[10])
        {
            Caption = 'Relative Code';
            DataClassification = ToBeClassified;
            TableRelation = Relative;
        }
        field(4; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                HRSetup.GET();
                HRSetup.TESTFIELD("Dependant Maximum Age");
                
                 IF CALCDATE(HRSetup."Dependant Maximum Age","Birth Date")<TODAY THEN
                  ERROR('The Minimum age for Dependants is '+FORMAT(HRSetup."Dependant Maximum Age"));
                */
            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Relative's Employee No."; Code[20])
        {
            Caption = 'Relative''s Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST("Employee Relative"), "No."=FIELD("Employee No."), "Table Line No."=FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Dependant; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                HRSetup.GET();
                HRSetup.TESTFIELD("Dependant Maximum Age");
                
                 IF CALCDATE(HRSetup."Dependant Maximum Age","Birth Date")<TODAY THEN
                  ERROR('The Minimum age for Dependants is '+FORMAT(HRSetup."Dependant Maximum Age"));
                */
            end;
        }
        field(12; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ", Male, Female;
        }
        field(13; "Dependant No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Date Registered"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Dependant No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
