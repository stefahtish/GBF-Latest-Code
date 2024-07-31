page 50705 "Transport incidents"
{
    CardPageId = "Transport Incident";
    Caption = 'Transport incidents';
    PageType = List;
    SourceTable = "Transport Incident";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Incident date"; Rec."Incident date")
                {
                    ApplicationArea = All;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = All;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    ApplicationArea = All;
                }
                field("Incident Reported"; Rec."Incident Reported")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Incident Location Name"; Rec."Incident Location Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
