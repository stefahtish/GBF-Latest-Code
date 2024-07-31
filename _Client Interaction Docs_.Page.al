page 50878 "Client Interaction Docs"
{
    PageType = ListPart;
    SourceTable = "Client Interactions Docs";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Client Interaction"; Rec."Client Interaction")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Provided; Rec.Provided)
                {
                }
                field("Document Link"; Rec."Document Link")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Attachment; Rec.Attachment)
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Attachment")
            {
                Caption = '&Attachment';

                action(Open)
                {
                    Caption = 'Open';
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec."Line No.", Rec."Language Code (Default)") then InteractTemplLanguage.OpenAttachment;
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec."Client Interaction", Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec."Client Interaction"; //"Line No.";
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        Rec.Attachment := Rec.Attachment::Yes;
                        Rec.Modify;
                    end;
                }
                action("Copy &from")
                {
                    Caption = 'Copy &from';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec."Client Interaction", Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec."Client Interaction"; //"Line No.";
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                            InteractTemplLanguage.Insert;
                            Commit;
                        end;
                        InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        Rec.Attachment := Rec.Attachment::Yes;
                        Rec.Modify;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec."Client Interaction", Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec."Client Interaction"; //"Line No.";
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                            InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        Rec.Attachment := Rec.Attachment::Yes;
                        Rec.Modify;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec."Client Interaction", Rec."Language Code (Default)") then InteractTemplLanguage.ExportAttachment;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec."Client Interaction", Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.RemoveAttachment(true);
                            Rec.Attachment := Rec.Attachment::No;
                            Rec.Modify;
                        end;
                    end;
                }
            }
            action("Check All Docs")
            {
                Caption = 'Check All Docs';
                Image = Apply;

                trigger OnAction()
                var
                    ClientIntDocs: Record "Client Interactions Docs";
                begin
                    ClientIntDocs.Reset;
                    ClientIntDocs.SetRange("Client Interaction", Rec."Client Interaction");
                    if ClientIntDocs.Find('-') then begin
                        repeat
                            ClientIntDocs.Provided := true;
                            ClientIntDocs.Modify;
                        until ClientIntDocs.Next = 0;
                    end;
                end;
            }
            action("UnCheck All Docs")
            {
                Caption = 'UnCheck All Docs';
                Image = UnApply;

                trigger OnAction()
                var
                    ClientIntDocs: Record "Client Interactions Docs";
                begin
                    ClientIntDocs.Reset;
                    ClientIntDocs.SetRange("Client Interaction", Rec."Client Interaction");
                    if ClientIntDocs.Find('-') then begin
                        repeat
                            ClientIntDocs.Provided := false;
                            ClientIntDocs.Modify;
                        until ClientIntDocs.Next = 0;
                    end;
                end;
            }
        }
    }
}
