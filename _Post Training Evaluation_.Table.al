table 50709 "Post Training Evaluation"
{
    Caption = 'Post Training Evaluation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Gender; Option)
        {
            OptionMembers = "", "Male", "Female", "Other";
        }
        field(3; "P/No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Age"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Ethnicity"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Designation"; Text[400])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Division/Unit"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Course Attended"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Venue"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Course Dates"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "End Date":=CalcDate(Duration, "Course Dates");
            end;
        }
        field(21; "Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Relevancy"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Employee No,"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                EmpRec: Record Employee;
            begin
                EmpRec.Reset();
                If EmpRec.Get("Employee No,")then begin
                    "Employee Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    Age:=Format(EmpRec."Date of Birth - Age");
                    Gender:=EmpRec.Gender;
                    Ethnicity:=EmpRec."Ethnic Community";
                    Designation:=EmpRec."Job Title";
                end;
            end;
        }
        field(24; "Employee Name"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Knowledge Applied"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employee Motivated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Improved Performance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Training Recommendation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "HOD Explanation"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "HOD Training"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Knowledge Explanation"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            GeneralSetUp.Get;
            GeneralSetUp.TESTFIELD("Post Training Evaluation Nos.");
            NoSeriesManagement.InitSeries(GeneralSetUp."Post Training Evaluation Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Date":=Today;
        "User ID":=UserId;
        if GuiAllowed then begin
            if UserSetup.get("User ID")then begin
                If EmpRec.Get(UserSetup."Employee No.")then "Employee No,":=EmpRec."No.";
                Validate("Employee No,");
            end;
        end;
    end;
    var GeneralSetUp: Record "Human Resources Setup";
    NoSeriesManagement: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    EmpRec: Record Employee;
}
