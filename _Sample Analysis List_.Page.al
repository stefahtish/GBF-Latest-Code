page 50971 "Sample Analysis List"
{
    Caption = 'Sample Transmission List';
    PageType = List;
    Editable = false;
    CardPageId = "Sample Analysis Card";
    SourceTable = "Sample analysis and reporting";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Analysis No."; Rec."Analysis No.")
                {
                    ApplicationArea = All;
                }
                // field("Sample temperature"; Rec."Sample temperature")
                // {
                //     ApplicationArea = All;
                // }
                field("Testing date"; Rec."Testing date")
                {
                    ApplicationArea = All;
                }
                field("Testing officer"; Rec."Testing officer")
                {
                    ApplicationArea = All;
                }
                // field("Lab section received"; Rec."Lab section received")
                // {
                //     ApplicationArea = All;
                // }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field("Results date"; Rec."Results date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Sample Targeted Tests Analysis"; "Sample Targeted Tests Analysis")
            {
                Caption = 'Sample Codes';
                SubPageLink = "Entry No." = field("Analysis No.");
            }
        }
    }
}
