table 50492 "ICT Issue Setup2"
{
    Caption = 'ICT Issue Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ICT Issue Categories";

            trigger OnValidate()
            var
                Categ: record "ICT Issue Categories";
            begin
                if Categ.get(Category)then "Category Description":=Categ."Category Description";
            end;
        }
        field(2; Issue; Text[500])
        {
            Caption = 'Issue';
            DataClassification = ToBeClassified;
        }
        field(3; Priority; Option)
        {
            OptionMembers = "", High, Medium, Low;
            OptionCaption = ' ,High,Medium,Low';
            DataClassification = ToBeClassified;
        }
        field(4; "Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Category, Issue)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Issue, Priority)
        {
        }
    }
}
