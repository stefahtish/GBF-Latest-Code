page 50373 "Imprest Surrender Line"
{
    Caption = 'Imprest Surrender Line';
    PageType = Card;
    SourceTable = "Payment Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Destination; Rec.Destination)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("No of Days"; Rec."No of Days")
                {
                    enabled = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                }
                field("Imprest Receipt No."; Rec."Imprest Receipt No.")
                {
                    Caption = 'Surrender Receipt No.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(links; Links)
            {
            }
        }
    }
}
