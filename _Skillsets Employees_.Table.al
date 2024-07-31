table 50325 "Skillsets Employees"
{
    fields
    {
        field(1; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; SkillSet; Code[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Skill Code";

            trigger OnValidate()
            var
                skillcode: record "Skill Code";
            begin
                if skillcode.Get(SkillSet)then Description:=skillcode.Description;
            end;
        }
        field(3; Description; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", SkillSet)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
