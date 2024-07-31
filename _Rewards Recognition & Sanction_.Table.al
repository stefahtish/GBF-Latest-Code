table 50719 "Rewards Recognition & Sanction"
{
    Caption = 'Rewards Recognition & Sanction';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            TableRelation = IF(Category=const(Recognition))"Recognitions and Rewards Setup" where(Category=const(Recognition))
            ELSE IF(Category=const(Rewards))"Recognitions and Rewards Setup" where(Category=const(Rewards), "Reward Type"=const(Monetary))
            ELSE IF(Category=const(Rewards))"Recognitions and Rewards Setup" where(Category=const(Rewards), "Reward Type"=const(Non_Monetary))
            ELSE IF(Category=CONST(Sanctions))"Recognitions and Rewards Setup" where(Category=const(Sanctions));

            trigger OnValidate()
            var
                Category1: Record "Recognitions and Rewards Setup";
            begin
                if Category1.Get(Code)then Description:=Category1.Description end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Category;Enum "Recognition & Rewards Category")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Clear(Code);
            end;
        }
        field(4; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Appraisal No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reward Type"; Option)
        {
            OptionMembers = " ", Monetary, "Non_Monetary";
        }
    }
    keys
    {
        key(PK; Code, "Appraisal No.", Category, "Reward Type")
        {
            Clustered = true;
        }
    }
}
