page 51468 "Monitory Reward"
{
    ApplicationArea = All;
    Caption = 'Monitory Reward';
    PageType = List;
    SourceTable = "Recognitions and Rewards Setup";
    UsageCategory = Administration;
    SourceTableView = where(Category=const(Rewards), "Reward Type"=const(Monetary));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Category:=Rec.Category::Rewards;
        Rec."Reward Type":=Rec."Reward Type"::Monetary;
    end;
}
