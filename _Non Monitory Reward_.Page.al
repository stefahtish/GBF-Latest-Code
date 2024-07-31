page 51470 "Non Monitory Reward"
{
    Caption = 'Non Monitory Reward';
    SourceTable = "Recognitions and Rewards Setup";
    PageType = List;
    UsageCategory = Administration;
    SourceTableView = where(Category = const(Rewards), "Reward Type" = const(Non_Monetary));
    ApplicationArea = All;

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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Category := Rec.Category::Rewards;
        Rec."Reward Type" := Rec."Reward Type"::Non_Monetary;
    end;
}
