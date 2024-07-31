table 50281 "Employee Beneficiaries"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Beneficiary No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Female, Male;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Beneficiary No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        //Beneficiary No Series
        BenPos:=0;
        Beneficiary.Reset;
        Beneficiary.SetRange("Employee No.", "Employee No.");
        if Beneficiary.Find('-')then begin
            BenPos:=Beneficiary.Count;
            BenNo:='BENF' + ' ' + ("Employee No.") + '/' + Format(BenPos + 1);
        end
        else
            BenNo:='BENF' + ' ' + Format("Employee No.") + '/' + Format(1);
        begin
        end;
        "Beneficiary No.":=BenNo;
    end;
    var BenPos: Integer;
    Beneficiary: Record "Employee Beneficiaries";
    BenNo: Code[20];
}
