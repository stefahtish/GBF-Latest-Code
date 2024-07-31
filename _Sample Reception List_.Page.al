page 50970 "Sample Reception List"
{
    CardPageId = "Sample reception card";
    PageType = List;
    Editable = false;
    SourceTable = "Sample Reception Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry officer"; Rec."Entry officer")
                {
                    ApplicationArea = All;
                }
                field("Lab section to test"; Rec."Lab section to test")
                {
                    ApplicationArea = All;
                }
                field("Sampling officer"; Rec."Sampling officer")
                {
                    ApplicationArea = All;
                }
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec."Testing Time")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Sample Targeted Tests"; "Sample Targeted Tests")
            {
                SubPageLink = "Entry No." = field("Entry No.");
            }
        }
    }
}
