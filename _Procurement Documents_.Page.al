page 50176 "Procurement Documents"
{
    Caption = 'Procurement Documents';
    PageType = ListPart;
    SourceTable = "Procurement Document";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Preview")
            {
                action("Preview Document")
                {
                    Image = Download;
                    ApplicationArea = all;
                    ToolTip = 'Preview Selected document.';

                    trigger OnAction()
                    var
                        OnlinePortal: Codeunit "Online Portal Services";
                        RecLink: Record "Record Link";
                        FileName: Text;
                        FileMgt: Codeunit "File Management";
                        TempFile: File;
                    begin
                        RecLink.Reset();
                        RecLink.SetFilter("Record ID", Rec."Document Code");
                        RecLink.SetRange("Link ID", Rec."Line No.");
                        IF RecLink.Findfirst() then begin
                            FileName := FileMgt.GetFileName(RecLink.URL1);
                            Clear(TempFile);
                            //eddie  Download(RecLink.URL1, '', '', '', FileName);
                        end;
                    end;
                }
            }
        }
    }
}
