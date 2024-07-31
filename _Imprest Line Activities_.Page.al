page 50197 "Imprest Line Activities"
{
    Caption = 'Imprest Line Activities';
    PageType = List;
    InsertAllowed = false;
    SourceTable = "Imprest Line Activities";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Transport Type"; Rec."Transport Type")
                {
                    ToolTip = 'Specifies the value of the Transport Type field';
                    ApplicationArea = All;
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
                }
                field("Estimated Mileage Amount"; Rec."Estimated Mileage Amount")
                {
                    ToolTip = 'Specifies the value of the Estimated Mileage Amount field';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Area field';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
