table 50522 "Training Evaluation Header"
{
    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Training Evaluation No." <> xRec."Training Evaluation No." then begin
                    HRSetup.Get;
                    HRSetup.TestField("Training Evaluation Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Evaluation Nos");
                end;
            end;
        }
        field(2; "Training Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Location"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Commencement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Duration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; UserID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                employee: Record Employee;
            begin
                if employee.Get("Personal No.")then "Name of participant":=employee."First Name" + '-' + employee."Middle Name" + '-' + employee."Last Name";
            end;
        }
        field(11; Country; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Name of participant"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Training No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Need";

            trigger OnValidate()
            var
                TrainingNeed: Record "Training Need";
            begin
                TrainingNeed.SetRange(Code, "Training No.");
                IF TrainingNeed.findfirst THEN BEGIN
                    Description:=TrainingNeed."Training Objectives";
                    "Training Name":=TrainingNeed."Training Objectives";
                    Location:=TrainingNeed.Location;
                    "Commencement Date":=TrainingNeed."Start Date";
                    "Completion Date":=TrainingNeed."End Date";
                END;
            end;
        }
    }
    keys
    {
        key(Key1; "Training Evaluation No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        UserID:=UserId;
        if "Training Evaluation No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Evaluation Nos");
            NoSeriesManagement.InitSeries(HRSetup."Training Evaluation Nos", xRec."No. Series", 0D, "Training Evaluation No.", "No. Series");
        end;
        if "User Setup".Get(UserId)then begin
            "User Setup".TestField("Employee No.");
            if Employee.Get("User Setup"."Employee No.")then begin
                "Personal No.":=Employee."No.";
                "Name of participant":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;
    end;
    var Employee: Record Employee;
    NoSeriesManagement: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
    "User Setup": Record "User Setup";
    local procedure GetEmpDetails(EmpNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpNo)then begin
            "Name of participant":=(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        end;
    end;
}
