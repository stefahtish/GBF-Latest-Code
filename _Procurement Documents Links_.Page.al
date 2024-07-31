page 51321 "Procurement Documents Links"
{
    Caption = 'Procurement Documents Links';
    PageType = List;
    Editable = false;
    SourceTable = "Procurement Document Links";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Link; Rec.Link)
                {
                    ApplicationArea = All;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    visible = false;
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
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
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
                        RecLink.SetRange("Record ID", Rec."Record ID");
                        RecLink.SetRange("Link ID", Rec.LineNo);
                        IF RecLink.Findfirst() then begin
                            FileName := FileMgt.GetFileName(RecLink.URL1);
                            Clear(TempFile);
                            //eddi Download(RecLink.URL1, '', '', '', FileName);
                        end;
                    end;
                }
            }
        }
    }
}
