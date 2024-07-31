table 50231 "Board of Director"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; SurName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Other Names"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Address; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; County; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Email; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Nationality; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Occupation; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Tenure);
            end;
        }
        field(17; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Appointment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Picture; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Tenure; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TenureText: Text;
            begin
                TenureText:=format(Tenure);
                if("Start Date" <> 0D) and (TenureText <> '')then begin
                    "End Date":=CalcDate(Tenure, "Start Date");
                    "Termination Date":=CalcDate(Tenure, "Start Date");
                end;
            end;
        }
        field(22; "Academic Qualifications"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Independent, Alternate;
            OptionCaption = ' ,Independent,Alternate';
        }
        field(23; "Alternate Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National Treasury", "State department of livestock";
            OptionCaption = 'National Treasury,State department of livestock';
        }
        field(24; "Huduma Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Race; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Ethnic Community"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ethnic Communities";
        }
        field(27; Religion; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Passport Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Position; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Ethnic Origin"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Black, "African American", Hispanic, Asian, Indian, White;
        }
        field(31; "Reappointment Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Tenure);
            end;
        }
        field(32; "Reappointment End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Reappointment Tenure"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TenureText: Text;
            begin
                TenureText:=format("Reappointment Tenure");
                if("Reappointment Start Date" <> 0D) and (TenureText <> '')then begin
                    "Reappointment End Date":=CalcDate(Tenure, "Start Date");
                end;
            end;
        }
        field(34; "ReAppointment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Reappoint; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            begin
                if Banks.get("Bank Code")then "Bank Name":=banks.Name;
            end;
        }
        field(37; "Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("Bank Code"));

            trigger OnValidate()
            begin
                if BankBranches.get("Bank Code", "Bank Branch Code")then "Bank Branch Name":=BankBranches."Branch Name";
            end;
        }
        field(38; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
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
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        HRSetup.Get;
    end;
    var Banks: Record Banks;
    BankBranches: Record "Bank Branches";
    HRSetup: Record "Human Resources Setup";
    BoardOfDirectors: Record "Board Appointment Logs";
    procedure InsertAppointmentDetails(var StartD: Date; var Term: DateFormula; var EndD: Date; var AppDate: Date)
    begin
        if "Start Date" = 0D then begin
            "Start Date":=StartD;
            Tenure:=Term;
            Validate(Tenure);
            "Appointment Date":=AppDate;
        end
        else
        begin
            "Reappointment Start Date":=StartD;
            "Reappointment Tenure":=term;
            Validate("Reappointment Tenure");
            "ReAppointment Date":=AppDate;
        end;
        BoardOfDirectors.Init();
        BoardOfDirectors.Code:=Code;
        BoardOfDirectors."Start Date":=StartD;
        BoardOfDirectors.Tenure:=Term;
        BoardOfDirectors."End Date":=EndD;
        BoardOfDirectors."Appointment Date":=AppDate;
        BoardOfDirectors.Insert();
    end;
}
