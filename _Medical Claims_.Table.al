table 50257 "Medical Claims"
{
    fields
    {
        field(1; "Claim No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Claim Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Service Provider"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider")then "Service Provider Name":=VendorRec.Name;
            end;
        }
        field(4; "Service Provider Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Claimant; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Service Provider", Employee;
        }
        field(7; Amount; Decimal)
        {
            CalcFormula = Sum("Claim Line".Amount WHERE("Claim No"=FIELD("Claim No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Settled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected;
        }
        field(11; "Transferred to Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50257), "Document No."=FIELD("Claim No")));
            FieldClass = FlowField;
        }
        field(13; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; OutEntitlement; Decimal)
        {
            CalcFormula = Sum("Medical Scheme Header"."Entitlement -OutPatient" WHERE("Employee No"=FIELD("Employee No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields(OutEntitlement, "Total Claims");
                Balance:=OutEntitlement - "Total Claims";
            end;
        }
        field(16; InEntitlement; Decimal)
        {
            CalcFormula = Sum("Medical Scheme Header"."Entitlement -Inpatient" WHERE("Employee No"=FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(17; "Total Claims"; Decimal)
        {
            CalcFormula = Sum("Claim Line".Amount WHERE("Employee No"=FIELD("Employee No")));
            FieldClass = FlowField;
        }
        field(18; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
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
    var VendorRec: Record Vendor;
    HumanResSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
}
