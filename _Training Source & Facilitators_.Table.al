table 50225 "Training Source & Facilitators"
{
    fields
    {
        field(1; Source; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Training Need"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(4; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employees.Reset;
                if Employees.Get(Code)then Names:=Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
            end;
        }
        field(5; Names; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Facilitator Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Source)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employees: Record Employee;
}
