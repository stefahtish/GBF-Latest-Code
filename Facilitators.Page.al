page 51339 Facilitators
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Activity Work Programme Lines";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description)
                {
                    Caption = 'Name / Description';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    Caption = 'Area';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No of Facilitator"; Rec."No of Facilitator")
                {
                    Caption = 'No. of facilitators';
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    Caption = 'No. of days';
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
                field("Transport"; Rec."Transport")
                {
                    Caption = 'Transport Amount';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    // area(Factboxes)
    // {
    // }
    }
    actions
    {
    // area(Processing)
    // {
    //     action(ActionName)
    //     {
    //         ApplicationArea = All;
    //         trigger OnAction();
    //         begin
    //         end;
    //     }
    // }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::Facilitators;
    end;
}
