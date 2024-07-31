page 51332 "Work Programme Participants"
{
    Caption = 'Participants';
    PageType = ListPart;
    SourceTable = "Activity Work Programme Lines";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the destination field';
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field';
                    ApplicationArea = All;
                }
                field("Transport Type"; Rec."Transport Type")
                {
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    ToolTip = 'Specifies the value of the Per Diem field';
                    ApplicationArea = All;
                }
                field(Transport; Rec.Transport)
                {
                    ToolTip = 'Specifies the value of the Transport field';
                    ApplicationArea = All;
                    Editable = rec."Transport Type" = Rec."Transport Type"::Transport;
                }
                field("Estimated Mileage Amount"; Rec."Estimated Mileage Amount")
                {
                    ApplicationArea = All;
                    Enabled = rec."Transport Type" = rec."Transport Type"::"Personal Vehicle";
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Participants;
    end;
}
