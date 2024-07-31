table 50256 "Claim Line"
{
    fields
    {
        field(1; "Claim No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /* Cheruiyot
                Beneficiary.RESET;
                Beneficiary.SETRANGE(Beneficiary."Employee Code","Patient No");
                IF Beneficiary.FIND('-')THEN
                "Patient Name":=Beneficiary.SurName+' '+Beneficiary."Other Names";
                */
            /*
                  TESTFIELD("Visit Date");
                   MedSchemeLines.RESET;
                  MedSchemeLines.SETRANGE(MedSchemeLines."Employee Code","Employee No");
                  MedSchemeLines.SETRANGE(MedSchemeLines."Line No.","Patient No");
                  IF MedSchemeLines.FIND('+') THEN
                  "Patient Name":=MedSchemeLines."Other Names"+' '+MedSchemeLines.SurName;
                  Relationship:=MedSchemeLines.Relationship;
                */
            end;
        }
        field(4; "Patient Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Hospital/Specialist"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                 claims.RESET;
                 claims.SETRANGE(claims."Claim No","Claim No");
                 claims.SETRANGE(claims."Employee No","Employee No");
                 IF claims.FIND('-') THEN BEGIN
                  IF claims."Invoice Number"="Invoice Number" THEN
                   ERROR('That Invoice number has already been captured!');
                 END;
                 */
            end;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                "Approved Amount":=Amount;
                MedicalSheme.RESET;
                MedicalSheme.SETRANGE(MedicalSheme."Employee No","Employee No");
                IF MedicalSheme.FIND('+') THEN
                BEGIN
                 MedicalSheme.CALCFIELDS(MedicalSheme."In-Patient Claims",MedicalSheme."Out-Patient Claims");
                 IF Amount+MedicalSheme."In-Patient Claims">MedicalSheme."Entitlement -Inpatient"  THEN
                 MESSAGE('By Accepting this claim you will be exceed the in-patient limit');

                 IF Amount+MedicalSheme."Out-Patient Claims">MedicalSheme."Entitlement -OutPatient"  THEN
                 MESSAGE('By Accepting this claim you will be exceed the out-patient limit');


                END;
                */
            end;
        }
        field(8; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if emp.Get("Employee No")then "Employee Name":=emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(10; "Medical Scheme"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Approved, Rejected, "Part Payment";
        }
        field(12; "Amount Spend (In-Patient)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(13; "Amout Spend (Out-Patient)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(14; "Claim Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,In Patient,Out Patient,Dental,Optical';
            OptionMembers = " ", "In Patient", "Out Patient", Dental, Optical;
        }
        field(15; "Balance (In-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Balance (Out-Patient)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Visit Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                AccountingP.Reset;
                AccountingP.SetRange(AccountingP."Starting Date", 0D, "Visit Date");
                AccountingP.SetRange(AccountingP."New Fiscal Year", true);
                if AccountingP.Find('+')then "Policy Start Date":=AccountingP."Starting Date";
            end;
        }
        field(18; "Employee Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Relationship; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Relative;
        }
        field(21; "Policy Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Commissioner Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                dimvalue.Reset;
                if dimvalue.Get('COMMISSIONERS', "Commissioner Code")then "Commissioner Name":=dimvalue.Name;
            end;
        }
        field(23; "Commissioner Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Settled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Directorate; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Department; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(28; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Patient; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Self,Dependant';
            OptionMembers = , Self, Dependant;

            trigger OnValidate()
            begin
                if Patient = Patient::Self then "Patient Name":="Employee Name";
            end;
        }
    }
    keys
    {
        key(Key1; "Claim No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var MedSchemeLines: Record Relative;
    MedicalSheme: Record "Medical Scheme Header";
    AccountingP: Record "Accounting Period";
    emp: Record Employee;
    claims: Record "Claim Line";
    dimvalue: Record "Dimension Value";
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    Beneficiary: Record Relative;
}
