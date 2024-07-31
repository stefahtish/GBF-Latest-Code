page 51460 "Document Links Part"
{
    Caption = 'Document Links Part';
    PageType = ListPart;
    Editable = false;
    SourceTable = "Record Link";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Link ID"; Rec."Link ID")
                {
                    ToolTip = 'Specifies the value of the Link ID field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(URL1; Rec.URL1)
                {
                    ToolTip = 'Specifies the value of the URL1 field';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
