page 50941 "Means of Handling Setup"
{
    Caption = 'Where Found Setup';
    PageType = List;
    SourceTable = "Means of Handling Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Means of Handling"; Rec."Means of Handling")
                {
                    ApplicationArea = All;
                    Caption = 'Where Found';
                }
                field("Modes of Handling"; Rec."Modes of Handling")
                {
                    ApplicationArea = All;
                    Caption = 'Mode of transport';
                }
                field("No vehicle registration no"; Rec."No vehicle registration no")
                {
                    Caption = 'Vehicle Registration No. not needed';
                }
            }
        }
    }
}
