page 50225 "FA Disposal List"
{
    ApplicationArea = All;
    Caption = 'FA Disposal List';
    PageType = List;
    SourceTable = "FA Disposal";
    UsageCategory = Lists;
    CardPageId = "FA Disposal Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
